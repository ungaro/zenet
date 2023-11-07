"use client";

import Image from "next/image";
import { Inter } from "next/font/google";
import {
  bigIntToString,
  parseNonStandardJSON,
  stringToBigInt,
} from "../utils/utils";
import {
  Account,
  AleoNetworkClient,
  NetworkRecordProvider,
  ProgramManager,
  KeySearchParams,
  AleoKeyProvider,
} from "@aleohq/sdk";

import { useWallet } from "@demox-labs/aleo-wallet-adapter-react";

import {
  Transaction,
  WalletAdapterNetwork,
  WalletNotConnectedError,
} from "@demox-labs/aleo-wallet-adapter-base";

import React, { FC, useCallback, useRef, useState, useEffect } from "react";

import { PhotoIcon, UserCircleIcon } from "@heroicons/react/24/solid";
const inter = Inter({ subsets: ["latin"] });

export default function Submit() {
  const {
    publicKey,
    requestTransaction,
    requestRecords,
    transactionStatus,
    wallet,
  } = useWallet();
  const contentArea = useRef(null);

  const [textAreaValue, setTextAreaValue] = useState("");

  let [transactionId, setTransactionId] = useState<string | undefined>();
  let [status, setStatus] = useState<string | undefined>();

  const handleChange = useCallback((event) => {


    const areaField = stringToBigInt(event.target.value);

    const shouldSetValue =
      areaField <=
      BigInt(
        "8444461749428370424248824938781546531375899335154063827935233455917409239040"
      );

    if (shouldSetValue) {
      setTextAreaValue(event.target.value);
    } else {
      event.preventDefault();
    }
  });

  useEffect(() => {
    async function getLoader() {
      const { ripples } = await import("ldrs");
      ripples.register();
    }
    getLoader();
  }, []);

  useEffect(() => {
    let intervalId: NodeJS.Timeout | undefined;

    if (transactionId) {
      intervalId = setInterval(() => {
        getTransactionStatus(transactionId!);
      }, 1000);
    }

    return () => {
      if (intervalId) {
        clearInterval(intervalId);
      }
    };
  }, [transactionId]);

  const onRecord = async () => {
    if (requestRecords) {
      const records = await requestRecords("credits.aleo");
      for (let i = 0; i < records.length; i++) {

        if (records[i].spent === false) {
          let targetRecord = records[i];
          break;
        }
      }
    }
  };

  const onFeedback = async () => {
    if (!publicKey) throw new WalletNotConnectedError();
    // The record here is an output from the Requesting Records above

    const input = stringToBigInt(contentArea.current.value) + "field";

    const inputs = [input];

    const fee = 367_178; // This will fail if fee is not set high enough
    const aleoTransaction = Transaction.createTransaction(
      publicKey,
      WalletAdapterNetwork.Testnet,
      process.env.NEXT_PUBLIC_PROGRAM_NAME,
      "submit",
      inputs,
      fee,
      process.env.NEXT_PUBLIC_PRIVATE_FEE
    );

    try {
      if (requestTransaction) {
        //const txId = await requestTransaction(aleoTransaction);
        const txId = await requestTransaction(aleoTransaction);

        setTransactionId(txId);
        console.log("TX", txId);
      }
    } catch (e: any) {
      console.log(aleoTransaction, "Transaction Failed");
    }
  };

  const getTransactionStatus = async (txId: string) => {
    const status = await transactionStatus(txId);
    setStatus(status);
  };


  return (
    <div className="bg-gray-800">
      <main
        className={`mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 bg-gray-800 py-16 ${inter.classNameName}`}>
        {publicKey ? (
          <>
            <div className="space-y-12">
              <div className="border-b border-white/10 pb-12">
                <h2 className="text-base font-semibold leading-7 text-white">
                  Submit your feedback
                </h2>
                <p className="mt-1 text-sm leading-6 text-gray-400">
                  This information will be displayed publicly so be careful what
                  you share.
                </p>

                <div className="mt-10 grid grid-cols-1 gap-x-6 gap-y-8 sm:grid-cols-6">
                  <div className="col-span-full">
                    <label
                      htmlFor="about"
                      className="block text-sm font-medium leading-6 text-white">
                      Enter your Feedback
                    </label>
                    <div className="mt-2">
                      <textarea
                        id="about"
                        name="about"
                        rows={3}
                        className="block w-full rounded-md border-0 bg-white/5 py-1.5 text-white shadow-sm ring-1 ring-inset ring-white/10 focus:ring-2 focus:ring-inset focus:ring-indigo-500 sm:text-sm sm:leading-6"
                        defaultValue={""}
                        ref={contentArea}
                        onKeyPress={(e) => {
                          handleChange(e);
                        }}
                      />
                    </div>
                    <p className="mt-3 text-sm leading-6 text-gray-400">
                      Enter your Feedback
                    </p>
                  </div>
                </div>
              </div>
            </div>

            <div className="mt-6 flex items-center justify-end gap-x-6">
              {transactionId && (
                <div className="text-white flex">
                  {status != "Finalized" && (
                    <div className="mt-0.5 mr-2">
                      <l-ripples color="white" size="30"></l-ripples>
                    </div>
                  )}{" "}
                  <div className="mt-1">
                    Transaction status:{" "}
                    <span className="pulsate"> {status}</span>
                  </div>
                </div>
              )}
              <button
                className="rounded-md bg-green-500 px-3 py-2 text-sm font-semibold text-black shadow-sm hover:bg-green-400 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-green-500"
                onClick={() => onFeedback()}>
                Save
              </button>
            </div>
          </>
        ) : (
          <p className="text-white">Please connect your wallet to give feedback.</p>
        )}{" "}
      </main>
    </div>
  );
}

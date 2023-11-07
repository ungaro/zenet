import { WalletProvider } from "@demox-labs/aleo-wallet-adapter-react";
import {
  WalletModalProvider,
  useWalletModal,
} from "@demox-labs/aleo-wallet-adapter-reactui";
import { LeoWalletAdapter } from "@demox-labs/aleo-wallet-adapter-leo";

import { useWallet } from "@demox-labs/aleo-wallet-adapter-react";

import {
  DecryptPermission,
  Transaction,
  WalletAdapterNetwork,
  WalletNotConnectedError,
  MessageSignerWalletAdapter,
} from "@demox-labs/aleo-wallet-adapter-base";
import { WalletMultiButton } from "@demox-labs/aleo-wallet-adapter-reactui";

require("@demox-labs/aleo-wallet-adapter-reactui/styles.css");

import Link from "next/link";

export default function Wallet() {
  return (
    <>
      <WalletMultiButton className="bg-[#154bf9]" />
    </>
  );
}

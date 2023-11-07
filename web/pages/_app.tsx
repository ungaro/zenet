

import '@/styles/globals.css'

import React, { FC, useMemo } from "react";


import { WalletProvider } from "@demox-labs/aleo-wallet-adapter-react";
import { WalletModalProvider } from "@demox-labs/aleo-wallet-adapter-reactui";
import { LeoWalletAdapter } from "@demox-labs/aleo-wallet-adapter-leo";
import {
  DecryptPermission,
  WalletAdapterNetwork,
} from "@demox-labs/aleo-wallet-adapter-base";
import Layout  from '../components/layout/Layout'

// Default styles that can be overridden by your app
require("@demox-labs/aleo-wallet-adapter-reactui/styles.css");



export default function App({ Component, pageProps }: AppProps) {


//export const Wallet: FC = ({ Component, pageProps }: AppProps) => {
  const wallets = useMemo(
    () => [
      new LeoWalletAdapter({
        appName: "Zenet Game",
      }),
    ],
    []
  );

  return (
    <WalletProvider
      wallets={wallets}
      decryptPermission={DecryptPermission.UponRequest}
      network={WalletAdapterNetwork.Localnet}
      autoConnect
    >
      <WalletModalProvider>
      <Layout>
  <Component {...pageProps} />
  
  </Layout>
      </WalletModalProvider>
    </WalletProvider>
  );
};



import Image from "next/image";
import { Inter } from "next/font/google";
import { bigIntToString, parseNonStandardJSON } from "../utils/utils";
import { endpoint_api, headers } from "../constants/constants";
import React, {
  useState,
  useEffect,
 
} from "react";
import { Dialog } from '@headlessui/react'
import { Bars3Icon, XMarkIcon } from '@heroicons/react/24/outline'
import { InboxIcon, TrashIcon, UsersIcon, BugAntIcon, ShieldCheckIcon, CurrencyDollarIcon, AdjustmentsHorizontalIcon, DocumentCheckIcon} from '@heroicons/react/24/outline'




const features = [
  {
    name: 'Submitting a Bug report.',
    description:
      'Users can submit a bug report privately. To protect the corporation from spam, bad user behavior or unusable feedback, the user has to attach a small security deposit to the report.',
    href: '#',
    icon: BugAntIcon,
  },
  {
    name: 'Protective fee.',
    description:
      "In order to save the community from being overrun by spam reports, users have to provide a protective fee when submitting that is returned to the user when deemed so by the community. If it's not returned, it can either be burned or shared between the company and the guardians, creating shareholders all throughout the process.",
    href: '#',
    icon: CurrencyDollarIcon,
  },
  {
    name: 'Guardian community.',
    description:
      'The community can now vote privately on the report being useful or not. If deemed useless or simply false, the security deposit is transferred to the corporation.',
    href: '#',
    icon: ShieldCheckIcon,
  },
  {
    name: 'Adjustment',
    description:
      'The corporation can now adjust their product or service according to the bug report. The submitter is given back the security deposit plus whatever the corporation decided to reward the submitter with off chain, due to KYC & AML. The corporation can decide to publish a statement about the problem.',
    href: '#',
    icon: AdjustmentsHorizontalIcon,
  },
  {
    name: 'Claim.',
    description:
      'The Submitter can now claim back his security deposit and reward payment using a ZK proof, being built from a  hash of the address and content. In this way, the user can stay anonymous all throughout the process while submitting feedback and receiving payment.',
    href: '#',
    icon: DocumentCheckIcon,
  },
]


const inter = Inter({ subsets: ["latin"] });

export default function Home() {
  //fetchAndDisplayData();
  const [reports, setReports] = useState(null);

  return (
    <>
     <div style={{backgroundColor:"#e9d3a2"}}>
      

      <div className="relative isolate overflow-hidden pt-14">
        <img
          src="/img/zenet_gameboard1.png"
          alt=""
          className="absolute inset-0 -z-10 h-full w-full object-contain"
        />
        <div
          className="absolute inset-x-0 -top-40 -z-10 transform-gpu overflow-hidden blur-3xl sm:-top-80"
          aria-hidden="true"
        >
          <div
            className="relative left-[calc(50%-11rem)] aspect-[1155/678] w-[36.125rem] -translate-x-1/2 rotate-[30deg] bg-gradient-to-tr from-[#ff80b5] to-[#9089fc] opacity-20 sm:left-[calc(50%-30rem)] sm:w-[72.1875rem]"
            style={{
              clipPath:
                'polygon(74.1% 44.1%, 100% 61.6%, 97.5% 26.9%, 85.5% 0.1%, 80.7% 2%, 72.5% 32.5%, 60.2% 62.4%, 52.4% 68.1%, 47.5% 58.3%, 45.2% 34.5%, 27.5% 76.7%, 0.1% 64.9%, 17.9% 100%, 27.6% 76.8%, 76.1% 97.7%, 74.1% 44.1%)',
            }}
          />
        </div>
        <div className="mx-auto max-w-2xl py-32 sm:py-48 lg:py-56">

          <div className="text-center">
            <h1 className="text-4xl font-bold tracking-tight text-white sm:text-6xl">
LOREM IPSUM
            </h1>
            <p className="mt-6 text-lg leading-8 text-gray-300">
            Senet is one of the oldest known board games, originating in ancient Egypt around 3100 BCE. It was a popular game among all social classes, from pharaohs to commoners. We've developed a modern ZK version called Zenet.





            </p>
            <div className="mt-10 flex items-center justify-center gap-x-6">
              <a
                href="/submit"
                className="rounded-md bg-indigo-500 px-3.5 py-2.5 text-sm font-semibold text-white shadow-sm hover:bg-indigo-400 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-400"
              >
               Create Game
              </a>
     
            </div>

            <div className="mt-10 flex items-center justify-center gap-x-6">
              <a
                href="/submit"
                className="rounded-md bg-indigo-500 px-3.5 py-2.5 text-sm font-semibold text-white shadow-sm hover:bg-indigo-400 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-400"
              >
               Join a Game
              </a>
     
            </div>


          </div>
        </div>
        <div
          className="absolute inset-x-0 top-[calc(100%-13rem)] -z-10 transform-gpu overflow-hidden blur-3xl sm:top-[calc(100%-30rem)]"
          aria-hidden="true"
        >
          <div
            className="relative left-[calc(50%+3rem)] aspect-[1155/678] w-[36.125rem] -translate-x-1/2 bg-gradient-to-tr from-[#ff80b5] to-[#9089fc] opacity-20 sm:left-[calc(50%+36rem)] sm:w-[72.1875rem]"
            style={{
              clipPath:
                'polygon(74.1% 44.1%, 100% 61.6%, 97.5% 26.9%, 85.5% 0.1%, 80.7% 2%, 72.5% 32.5%, 60.2% 62.4%, 52.4% 68.1%, 47.5% 58.3%, 45.2% 34.5%, 27.5% 76.7%, 0.1% 64.9%, 17.9% 100%, 27.6% 76.8%, 76.1% 97.7%, 74.1% 44.1%)',
            }}
          />
        </div>
      </div>
    </div>





    </>
  );
}

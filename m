Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85C592AD88A
	for <lists+dmaengine@lfdr.de>; Tue, 10 Nov 2020 15:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731961AbgKJOTe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Nov 2020 09:19:34 -0500
Received: from mga04.intel.com ([192.55.52.120]:22917 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730432AbgKJOTd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 10 Nov 2020 09:19:33 -0500
IronPort-SDR: k8EeUTT8oFEE72KtXcVX6Cp6o6/4uUKYW8Q7AenJ4DBeJd7pbuzQngBVb9YNfYjIo7PD++om7+
 DiMvqTFOQkCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="167395167"
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="167395167"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 06:19:30 -0800
IronPort-SDR: hY16sf6hyMU6v0zJxjUSvKW+LZ3JhgqWgbEbmWWhfXvgzIZekPFJN3Z+LDb6LghDPK88bk5jph
 FCGYYtINrHMA==
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="338737556"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 06:19:29 -0800
Date:   Tue, 10 Nov 2020 06:19:28 -0800
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "Dey, Megha" <megha.dey@intel.com>,
        "maz@kernel.org" <maz@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, "Lu, Baolu" <baolu.lu@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "jing.lin@intel.com" <jing.lin@intel.com>,
        "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "parav@mellanox.com" <parav@mellanox.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "netanelg@mellanox.com" <netanelg@mellanox.com>,
        "shahafs@mellanox.com" <shahafs@mellanox.com>,
        "yan.y.zhao@linux.intel.com" <yan.y.zhao@linux.intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Ortiz, Samuel" <samuel.ortiz@intel.com>,
        "Hossain, Mona" <mona.hossain@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v4 06/17] PCI: add SIOV and IMS capability detection
Message-ID: <20201110141928.GC22336@otc-nc-03>
References: <20201104135415.GX2620339@nvidia.com>
 <MWHPR11MB1645524BDEDF8899914F32AE8CED0@MWHPR11MB1645.namprd11.prod.outlook.com>
 <20201106131415.GT2620339@nvidia.com>
 <20201106164850.GA85879@otc-nc-03>
 <20201106175131.GW2620339@nvidia.com>
 <CAPcyv4iYHA1acfo=+fTk+U_TrLbSWJjA6v4oeTXgVYDTrnCoGw@mail.gmail.com>
 <20201107001207.GA2620339@nvidia.com>
 <20201108181124.GA28173@araj-mobl1.jf.intel.com>
 <20da76a4cd2e984a307d673e26f76ab73bd820f4.camel@infradead.org>
 <20201108232557.GA32074@araj-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201108232557.GA32074@araj-mobl1.jf.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi David

I did't follow the support for 32768 CPUs in guest without IR support.

Can you tell me how that is done?

On Sun, Nov 08, 2020 at 03:25:57PM -0800, Ashok Raj wrote:
> On Sun, Nov 08, 2020 at 06:34:55PM +0000, David Woodhouse wrote:
> > > 
> > > When we do interrupt remapping support in guest which would be required 
> > > if we support x2apic in guest, I think this is something we should look into more 
> > > carefully to make this work.
> > 
> > No, interrupt remapping is not required for X2APIC in guests
> > 
> > They can have X2APIC and up to 32768 CPUs without needing interrupt
> 
> How is this made available today without interrupt remapping? 
> 
> I thought without IR, the destination ID is still limited to only 8 bits?
> 
> On native, even if you have less than 255 cpu's but the APICID are sparsly 
> distributed due to platform rules, the x2apic id could be more than 8 bits. 
> Which is why the spec requires IR when x2apic is enabled.
> 
> > remapping at all. Only if they want more than 32768 vCPUs, or to do
> > nested virtualisation and actually remap for the benefit of *their*
> > (L2+) guests would they need IR.

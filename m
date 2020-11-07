Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A012AA20F
	for <lists+dmaengine@lfdr.de>; Sat,  7 Nov 2020 02:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbgKGBmn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Nov 2020 20:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbgKGBmm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 6 Nov 2020 20:42:42 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7732DC0613D4
        for <dmaengine@vger.kernel.org>; Fri,  6 Nov 2020 17:42:42 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id za3so4465477ejb.5
        for <dmaengine@vger.kernel.org>; Fri, 06 Nov 2020 17:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AAhKBkCmEXM9Yi0i53SdXI+qBrNsxTbz7k8CU/bDcxE=;
        b=Q5f2DNkIqXGoWxDYREtewdyEbZUybPhjCmtZWiOs07KT59R+F8HvZmDkmeiHpMIHZ7
         q0TC1JEW66CpLHwoFY5rkjCg1Zfgx+gz2vWz+4vAHmprlCjrjguRm2rAAcmyavS+Dc6a
         1hxpnTl0eFa/qeKJgQydyBmSXTnfC9S+GI8YrUVtEpiiavNEEgHiPzS1M3VOXANrRMQX
         3ch02mlhVpzhVIb4A1C32dAt0fG2PF9mXxHaEcijBAkHvV0L/IhEnOVuHwYpkKB9id82
         kQhyZveB+JXyoLJYMcRvhgmwKFLdQ4jpdDKervjjCZcjqGzUSC4NRyaXBW3oia07bw/Y
         jYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AAhKBkCmEXM9Yi0i53SdXI+qBrNsxTbz7k8CU/bDcxE=;
        b=YX50AMlq2oicPH7DraP1rXu2CYSzqtLrvVJCmBrN3UvMssqmD5lFy15K0PgSNLu4we
         2QGMZ00P/OazhwBDobLxxv5QThKhzYmI2zNtOiWgpgwevs+2M4bN6eL/tsZvDrN/2XQz
         EETZRUh+NXKUzF64+qoNnLt/hT1JfwkGBlm58O4c9LTiCf/hV9jI09dc28tPz6SkjUOK
         ePCWTwko7RWMpkDdS0/XgAuA4dpletQNI91abVzW26EVZYGD1FwPk/KD4ol4w9CSynAh
         44Kcc1/kyY+3vtMgwi3b/z4ofkcsPG+9rXIURSRtmYBf0m565eHYZeMK7MRjoc9QP8QT
         5jYg==
X-Gm-Message-State: AOAM530R9eEPVSV+bMZ6r8V+8PUhwpXfxBA8vNtbAq/K62c+vLy09bqX
        po4wXVp/w+V4cviJMtgBWNrheWFLu2iANUQ1YPxs4w==
X-Google-Smtp-Source: ABdhPJzEd/8ZnfumsYWdUvKYbtgyhZ6rEI5Gf3Kp1ROzCvGK7kQhLkgAhO25jWgDP1kq1OpwiV+3HUJrMEWDbkDVxaQ=
X-Received: by 2002:a17:906:70cf:: with SMTP id g15mr4788410ejk.323.1604713360965;
 Fri, 06 Nov 2020 17:42:40 -0800 (PST)
MIME-Version: 1.0
References: <20201103124351.GM2620339@nvidia.com> <MWHPR11MB164544C9CFCC3F162C1C6FC18CEF0@MWHPR11MB1645.namprd11.prod.outlook.com>
 <20201104124017.GW2620339@nvidia.com> <MWHPR11MB1645862A8F7CF7FB8DD011778CEF0@MWHPR11MB1645.namprd11.prod.outlook.com>
 <20201104135415.GX2620339@nvidia.com> <MWHPR11MB1645524BDEDF8899914F32AE8CED0@MWHPR11MB1645.namprd11.prod.outlook.com>
 <20201106131415.GT2620339@nvidia.com> <20201106164850.GA85879@otc-nc-03>
 <20201106175131.GW2620339@nvidia.com> <CAPcyv4iYHA1acfo=+fTk+U_TrLbSWJjA6v4oeTXgVYDTrnCoGw@mail.gmail.com>
 <20201107001207.GA2620339@nvidia.com>
In-Reply-To: <20201107001207.GA2620339@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 6 Nov 2020 17:42:29 -0800
Message-ID: <CAPcyv4hEYLVn_RmYjvfCaEtnvqrBAd0V9KgHmjQuBLy4GEw+_A@mail.gmail.com>
Subject: Re: [PATCH v4 06/17] PCI: add SIOV and IMS capability detection
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
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
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Nov 6, 2020 at 4:12 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Fri, Nov 06, 2020 at 03:47:00PM -0800, Dan Williams wrote:
[..]
> The only sane way to implement this generically is for the VMM to
> provide a hypercall to obtain a real *working* addr/data pair(s) and
> then have the platform hand those out from
> pci_subdevice_msi_create_irq_domain().

Yeah, that seems a logical attach point for this magic. Appreciate you
taking the time to lay it out.

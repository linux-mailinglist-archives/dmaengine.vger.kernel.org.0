Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA1F248C7A
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 19:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgHRRGI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 13:06:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50710 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728379AbgHRRFY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 13:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597770321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4KjP4tLJ3k//LfnATZoQR9lS9r+FC1/WEhYpN5z380g=;
        b=N7CkjNRtevWJeyx4S0Ri2o0DfYAKBbyDsZPbVJCtqLTwr2nv/Kdbod1mQb8qAUFiIkkYbA
        TNBkaNNW1Q0D6UPNFv4h0wzaaBhro2+IwpbCE+Lj+gvWpuDNfb9rJJPv1i36NLqspb3jqH
        PZs25MzOijeF2Qy5Zm0UAJFUx5jsRoU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458--UGwJDohNYy7nWMuqmb1dg-1; Tue, 18 Aug 2020 13:05:19 -0400
X-MC-Unique: -UGwJDohNYy7nWMuqmb1dg-1
Received: by mail-wr1-f69.google.com with SMTP id b13so8481774wrq.19
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 10:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4KjP4tLJ3k//LfnATZoQR9lS9r+FC1/WEhYpN5z380g=;
        b=L3FonZNkHP1lobUCRk82IdevxGJvIsgTjiY0/NA2bNs2Jl85bbzRmbP3GWTKk6R3TP
         cAOxwAF+Emh63ldEvj9NnmqRoehIraGviSloscjvO3QW/k4tXev2F82XYm+oSQXIoIvT
         t0zzYn3cNeoa1wkAF3KrMraWSG9aFFqkEJ54vPglPmXJfCDQhCi89vuCkzEcpwzjO/f3
         JfcuU3r1jRhBmJGYY3jLLtn0DeN2GE/UKKyG2EXwCaWwmnSRUrzq6mf3nH0vrmCYzbcC
         ejOIpMx4mKIvQSkphXm3c+ZIGfVx5tNUtmxAN+M/LONG5xOnM8IkGVcCoCTO6BufsmZ7
         T38w==
X-Gm-Message-State: AOAM532Xl0HET9pxQrJwRTeuHlp1S3u434TszV0K8natnvY+STcNorqY
        qpf7Q8biObChaaJYVQy0XPh5Jp3zOYp+d5TqgNUPbkC7HufHUn4iKi5RW3Rr0yMxwcNnLxBrsXX
        VitOfJAqqZA3a1gRyvaRh
X-Received: by 2002:a1c:9952:: with SMTP id b79mr857666wme.68.1597770318665;
        Tue, 18 Aug 2020 10:05:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJU6TWMw/VYVpnpZqdnTB8Di51Urdb66TwCceH6QwuuehUW2mW7IXuxEigHeEneYQy0GJBaw==
X-Received: by 2002:a1c:9952:: with SMTP id b79mr857644wme.68.1597770318432;
        Tue, 18 Aug 2020 10:05:18 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:38e0:ccf8:ca85:3d9b? ([2001:b07:6468:f312:38e0:ccf8:ca85:3d9b])
        by smtp.gmail.com with ESMTPSA id t25sm719265wmj.18.2020.08.18.10.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 10:05:17 -0700 (PDT)
Subject: Re: [PATCH RFC v2 00/18] Add VFIO mediated device support and DEV-MSI
 support for the idxd driver
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "Dey, Megha" <megha.dey@intel.com>,
        "maz@kernel.org" <maz@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, "Lu, Baolu" <baolu.lu@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Lin, Jing" <jing.lin@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "parav@mellanox.com" <parav@mellanox.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "netanelg@mellanox.com" <netanelg@mellanox.com>,
        "shahafs@mellanox.com" <shahafs@mellanox.com>,
        "yan.y.zhao@linux.intel.com" <yan.y.zhao@linux.intel.com>,
        "Ortiz, Samuel" <samuel.ortiz@intel.com>,
        "Hossain, Mona" <mona.hossain@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <20200724001930.GS2021248@mellanox.com>
 <20200805192258.5ee7a05b@x1.home> <20200807121955.GS16789@nvidia.com>
 <MWHPR11MB16452EBE866E330A7E000AFC8C440@MWHPR11MB1645.namprd11.prod.outlook.com>
 <20200814133522.GE1152540@nvidia.com>
 <MWHPR11MB16456D49F2F2E9646F0841488C5F0@MWHPR11MB1645.namprd11.prod.outlook.com>
 <20200818004343.GG1152540@nvidia.com>
 <MWHPR11MB164579D1BBBB0F7164B07A228C5C0@MWHPR11MB1645.namprd11.prod.outlook.com>
 <20200818115003.GM1152540@nvidia.com>
 <0711a4ce-1e64-a0cb-3e6d-f6653284e2e3@redhat.com>
 <20200818164903.GA1152540@nvidia.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <07fca197-3587-a45e-640b-bab0858067e2@redhat.com>
Date:   Tue, 18 Aug 2020 19:05:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200818164903.GA1152540@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18/08/20 18:49, Jason Gunthorpe wrote:
> On Tue, Aug 18, 2020 at 06:27:21PM +0200, Paolo Bonzini wrote:
>> On 18/08/20 13:50, Jason Gunthorpe wrote:
>>> For instance, what about suspend/resume of containers using idxd?
>>> Wouldn't you want to have the same basic approach of controlling the
>>> wq from userspace that virtualization uses?
>>
>> The difference is that VFIO more or less standardizes the approach you
>> use for live migration.  With another interface you'd have to come up
>> with something for every driver, and add support in CRIU for every
>> driver as well.
> 
> VFIO is very unsuitable for use as some general userspace. It only 1:1
> with a single process and just can't absorb what the existing idxd
> userspace is doing.

The point of mdev is that it's not 1:1 anymore.

Paolo

> So VFIO is already not a solution for normal userspace idxd where CRIU
> becomes interesting. Not sure what you are trying to say?
> 
> My point was the opposite, if you want to enable CRIU for idxd then
> you probably need all the same stuff as for qemu/VFIO except in the
> normal idxd user API.
> 
> Jason
> 


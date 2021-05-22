Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF8438D5B1
	for <lists+dmaengine@lfdr.de>; Sat, 22 May 2021 13:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhEVLot (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 22 May 2021 07:44:49 -0400
Received: from mail-eopbgr120073.outbound.protection.outlook.com ([40.107.12.73]:19606
        "EHLO FRA01-PR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230238AbhEVLot (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 22 May 2021 07:44:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Weh2tsGe8ZZ+J3DXkeSUCJENba3T+BbMdRz6i4D8zWoOsWRRSwOxk2AeYew8FYXxVEGXfNNxOxTM08GaQdLyZb4Tv1k9wYACdql8qe65Nvtqtzp7vz+MPSvmNbGv1HUlTtjPMTA+RL6K1Tr7zt+hiVDwmIH4A4EEi3lRIFYFpsfiKuBJofl5ZWmaNmBDJkhm6mKY7lxL8hkPjzrSMZm/GRf41h+Vt/fwuWqsRJjrn4hhn+iJOdK5RA1J5a3ZxMMrDKYR5HQk/CbJWC2xIy4iapS8Tty1GCfZ6PnaKwAIG8YtkhbpCqJf9arN9m/HLywmvvqs9nJgUKMyP9fvpheB2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcU8H+x+rTfr1FvcKIfkbiGg8fP2NWWVZHvhbcP4EbM=;
 b=LjHEvf2UrfNqV32OVcrzgLf8Wx9A3wLlfL+Y3E7aqJu17jmMST2iMOEffwTAcm19zNQsdtvD4DJ5Se3GVANmv1kZfDi2NqWmpl4zIhgMTocg+tZAe5jNkoGfCyS+YmatROKH5kuIwsidw3/nIkEpDZ7+sedwVUlKDaHqkvEmkzyb7/I1O0P/dE3W5fvoa7NrIbOkwo1FKVZ0zAJ/pY3xucQrzbLU9SM8qyGT2v98Zs6/Zc5QEpp51a6Di4F44H2R3RDxIYewNtAay3ffFNyXJlxCpHgYXfFEUdHiVD/VBu+zrrcRgD5LtOFxbU43we0sEb4u8CoqmRNNI+JM5XYTQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=orolia.com; dmarc=pass action=none header.from=orolia.com;
 dkim=pass header.d=orolia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orolia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcU8H+x+rTfr1FvcKIfkbiGg8fP2NWWVZHvhbcP4EbM=;
 b=oGDWFgO2dLm75UKYGIXPi+YF08KilLlTf/EtGPBKeb/bLkIyd7O5TILb1CDgI2QA6ep/hbgPbSDuynoU6JG332oUsHQsQFnpbUpCgu2gM1Gj+oJAU3VmkSi93qAY9Pmwtk+rExDkZaOuEPWrEWgbuVqBGXZket/1ZXmi3A+FHWE=
Authentication-Results: crapouillou.net; dkim=none (message not signed)
 header.d=none;crapouillou.net; dmarc=none action=none header.from=orolia.com;
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com (2603:10a6:102:11::28)
 by PR1PR06MB5963.eurprd06.prod.outlook.com (2603:10a6:102:10::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Sat, 22 May
 2021 11:43:21 +0000
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::81ef:de90:c451:d6e3]) by PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::81ef:de90:c451:d6e3%5]) with mapi id 15.20.4150.023; Sat, 22 May 2021
 11:43:21 +0000
Date:   Sat, 22 May 2021 13:42:54 +0200
From:   Olivier Dautricourt <olivier.dautricourt@orolia.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Subject: Re: Possible bug when using dmam_alloc_coherent in conjonction with
 of_reserved_mem_device_release
Message-ID: <YKjuPtO4NbDe2MLM@orolia.com>
References: <YKf4zlklLdfJBN6p@orolia.com>
 <4S7ITQ.ORCLYUEJD8BH3@crapouillou.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4S7ITQ.ORCLYUEJD8BH3@crapouillou.net>
X-Originating-IP: [2a01:e34:ec42:fd70:167:681b:bc47:e8b1]
X-ClientProxiedBy: PR3P191CA0047.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:55::22) To PR1PR06MB4746.eurprd06.prod.outlook.com
 (2603:10a6:102:11::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from orolia.com (2a01:e34:ec42:fd70:167:681b:bc47:e8b1) by PR3P191CA0047.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:55::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26 via Frontend Transport; Sat, 22 May 2021 11:43:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4e1d202-71db-451f-ab75-08d91d16ccb2
X-MS-TrafficTypeDiagnostic: PR1PR06MB5963:
X-Microsoft-Antispam-PRVS: <PR1PR06MB596367B827DB1E40BD34CE9E8F289@PR1PR06MB5963.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xuv/3MmIjKSjPhQBk2f14HH4ZWCzy3y9eh1NI1ulC3Bn1cHzhviCRXiMpw2ypXcqzcIjgQtJvhn2IpMLsLUXmVSYrJMwLseaUBAHx3nNpRGZ9SpLinoeg0aPS6vQmFFbfUm7AQqFNj37PkExpxoyA7sDvPxr9ZIDdOyHkZepxZaz13YBnbv8r8Yor/7ofps75RkIENLN+secRVkhV7UR+53jGYVLjO96hN8Qbwo+X5xuhFeGUIHH4SDEWrJtLaGPyK0QNQnGtZYAHg+L+66laTxkQ6/e4gAhcz8o+FHV5CUH/jzAWH12PEDofD1rFrPiHb+/B/AFkZNl9XqEYcNbb8UPWglbT6M0Jd6MIHvuGf8ANds6SCIAId0A4/s2QAQaB+zdanYd1Bb12ok7QVsd4u464Nf1V/Q6zY1WeOX+5yoQ10J86m3ZCfGgfHF5qBuWbv2zgl2T5m/WwA036W+XzmEMF9mPOJ1CwQc2tXfaPQK9i/Lr8KJ5e+UF11pwvRGAvk39fx4QYhxTg01GOXmNNWgTYzQykogHCLPRl2nPbkdIBnHGzCduPw+/H0lPcvxAVFDZN4OK57XL5ZOvxSy0FWS++oeGwil/keR+LijTfY4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR06MB4746.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(396003)(136003)(376002)(366004)(346002)(5660300002)(2906002)(6666004)(86362001)(36756003)(38100700002)(66556008)(83380400001)(55016002)(7696005)(66574015)(44832011)(316002)(478600001)(8936002)(2616005)(66476007)(4326008)(8886007)(6916009)(186003)(16526019)(8676002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZGFzOXovUThVQXY1eXdFMjk4SlJZTXhBSjlseVViMGEvU3RiWU03bTVxNktS?=
 =?utf-8?B?dUFUY0dWVVoyN2ZybnZ0V1liRGhheWVqZW5IUHd3V0VINThDWWhkNEVHNExo?=
 =?utf-8?B?bFM1alcxdStCd3NNakNhcmMzN1FqRWpsME5qYlhYL3pPaWFlV3RKUXFPM2Ir?=
 =?utf-8?B?ejExVVZnTDIrU0h2YmN0QmdtZGFtTENUWWVyOXBVVDdXNXIzTHJXWThxQ09F?=
 =?utf-8?B?VUZSbHhXd1Q5TERPL0FySUZBazUxMm1oRlNEZ3RYZlg4bDVDUEZPUlNlSnJt?=
 =?utf-8?B?aS91K0Nhd3lza0svVk5jVHdLREp1enNhd0VSb21LVXBjbmVKbUNtczBsMnBF?=
 =?utf-8?B?THRNcmJSVUdGNHVDWXRTUmErb0YrbWlzR0ZjUjFvb0Z0WDRTSDgrenFRSGRT?=
 =?utf-8?B?c1NyQU9SdU1MaUl1NnJBK2tjcms2WkhwOWJwdWRJb1ppclU1NXJRRUVONzY3?=
 =?utf-8?B?RW42aHdqUW1scER3MUJmSEtVS250clpmRDJkZ1A5NEFBZGdVZWFOcTd6dlVz?=
 =?utf-8?B?Vms0WU1nS2tua0MvcmxZQzJ3Z2UvUi84M3lHeUVFV25SN05jUEp5WG9JSFZM?=
 =?utf-8?B?QWN4RlY1WDBSbERPMkVRZVlCclBPT2FNc2c0T3h0NkpHa3UzeklWcnNMbUdH?=
 =?utf-8?B?L1I5V1NRSVBZOUFzSWhGd2syZ1l4RjBPWDZTb3dZUk9vd29CRTZJZWV0UnIx?=
 =?utf-8?B?azRZVUphSHV6bVRuNGFPNTU3ZVQwdmgwY2dOUWYxeStWbnYyQjBQTEw5cStl?=
 =?utf-8?B?bU9WU2V6V0dTdVdyL2U3cVJNS3dPUkJFKzlaN3dwcXlmMUk0cVRrdzFXMXBV?=
 =?utf-8?B?WlRvcUFIRlNqdHNDWW5SOWRicCtnQnkxZE8vRmFUUjVHSFV1YlZGL2tLc1Fp?=
 =?utf-8?B?VTR3OWFDWEdBS2wwSUJEaTR1WTh1cWlVUGtVbmR3QlUwM0czemlJVGk0VjIz?=
 =?utf-8?B?cCtkUXYxVHJ3U0dNY1FwOVd2MVZsS3BuY2JmeTZqa1ZrVnlXcnRtRzJrMEkw?=
 =?utf-8?B?VUVGcENaQnhuZ0cwb1c2SVVIaHZsZG9FZFdQL3F2eUxpWHN0dDhVRXF3S1l3?=
 =?utf-8?B?dmhETjBOMWVlUlUwcmMzREhUd0hlZ1JLN21SRkxtYXgyUFoxL2EzcjFoWEFG?=
 =?utf-8?B?SkFvRG5Eenc5eGtIQjdKOFU1Z1doc3EyNEdnSGJvVHFjZFk1bGhreFlvQVpm?=
 =?utf-8?B?R1k1M2U3M3FEMkR6anl2dEhPTkNJZHpTV3BTMkJ2RU9tNWlHSEpncjhEZkZ1?=
 =?utf-8?B?RzlzKzFKSG5SQVp5TGlweW9qWjFwUS9GcWZadFFIckRaaWRIYy9UQ3YzYlY4?=
 =?utf-8?B?RnJCQ3k3YXA5MHU5K2RxK2ZCR3ZCQ3lUNXI0dFQ1b2NmVEhsWC8zVUVWcUxP?=
 =?utf-8?B?dU1ER0JxbThjMGZvRFQ4UUtxdzNKanNQRXpCUm42dm15Tk9EaDJmM0ZTcXBG?=
 =?utf-8?B?L2ZxM3AyRFRRaThOR01CNnVvUmxaZGtSRmpGQjMwdFRnc2lPSFFmMXl6TnZY?=
 =?utf-8?B?Y0YwWGJZNEdGNm16QVlBTlJCNXFjN3hOcitYZzRlZGhCMmhVSlUzRnFJN3lv?=
 =?utf-8?B?WTc5U1drNjRFT2NaaWh5b3BKNlUyeE12THpzQ3NPYmo4Z0NpdGFSeFhSZ0lR?=
 =?utf-8?B?ZGc5ajRYMnUybDFRM0VscloxVHVRUG00bmpDVnhieWdzR0M3R2ZZLy9JalVa?=
 =?utf-8?B?RWRUSG5WU2VwTEJJendFNU9SQU9nZTZPU1lOVitQS3pFN3hudEkrYUtGTlhI?=
 =?utf-8?B?ZjNNbnZWTGI1MmdpbEx0OC9ROXk0RnFnZS8vWGYwb3FBeVpNcEU2RlN5cHZ3?=
 =?utf-8?B?dXltWHVNaWRuVEZWRzBiRDl1eitQd1d3V05hMXlUYmdLU1N4K3RrdFEzRmY0?=
 =?utf-8?Q?HkE4Lo6Qnij2l?=
X-OriginatorOrg: orolia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e1d202-71db-451f-ab75-08d91d16ccb2
X-MS-Exchange-CrossTenant-AuthSource: PR1PR06MB4746.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2021 11:43:21.1842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a263030c-9c1b-421f-9471-1dec0b29c664
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QD9+zdu8pzIMTwmvwlHGJIXAMKhimHcF4dYEG8oxVwRdQFDDktJptTfM7nRwdyys9PJ7uhdYRk+Ip5YQt17EoLgzDc/E0KEtg3RBdtHPSwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1PR06MB5963
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Paul,

The 05/22/2021 11:28, Paul Cercueil wrote:
> Hi Olivier,
>
>
> Le ven., mai 21 2021 at 20:15:42 +0200, Olivier Dautricourt
> <olivier.dautricourt@orolia.com> a écrit :
> > Hello all,
> >
> > I am facing a problem when using dmam_alloc_coherent (the managed
> > version of dma_alloc_coherent) along with a device-specific reserved
> > memory
> > region using the CMA.
> >
> > My observation is on a kernel 5.10.19 (arm), as i'm unable to test
> > the exact
> > same configuration on a newer kernel. However it seems that the
> > relevent code
> > did not change too much since, so i think it's still applicable.
> >
> >
> > ....
> > The issue:
> >
> > I declare a reserved region on my board such as:
> >
> > mydevice_reserved: linux,cma {
> >         compatible = "shared-dma-pool";
> >         reusable;
> >         size = <0x2400000>;
> > };
> >
> > and start the kernel with cma=0, i want my region to be reserved to
> > my device.
> >
> > My driver basically does:
> >
> > probe(dev):
> >       of_reserved_mem_device_init(dev)
> >       dmam_alloc_coherent(...)
> >
> > release(dev):
> >       of_reserved_mem_device_release(dev)
>
> You must make sure that whatever is allocated or initialized is freed
> or deinitialized in the reverse order, which is not what will happen
> here: release(dev) will be called before the dev-managed cleanups.
>
> To fix your issue, either use dma_alloc_coherent() and call
> dma_free_coherent() in release(), or register
> of_reserved_mem_device_release() as a dev-managed cleanup function
> (which is what my driver does).
>
> Cheers,
> -Paul

as i was saying in my previous mail, i tried to register a devm action
to trigger of_reserved_mem_device_release on cleanup but it was still
called before dmam_alloc_coherent_memory's cleanup.

So my question is: How do you make sure that the managed cleanup routines
are executed in the right order ?

Should we have to care about that when using a managed
function that belongs to the core ?


Olivier
>
> > On driver detach, of_reserved_mem_device_release will call
> > rmem_cma_device_release which sets dev->cma_area = NULL;
> > Then the manager will try to free the dma memory allocated in the
> > probe:
> >
> > __free_from_contiguous -> dma_release_from_contiguous ->
> > cma_release(dev_get_cma_area(dev), ...);
> >
> > Except that now dev_get_cma_area will return
> > dma_contiguous_default_area
> > which is null in my setup:
> >
> > static inline struct cma *dev_get_cma_area(struct device *dev)
> > {
> >       if (dev && dev->cma_area) // dev->cma_area is null
> >               return dev->cma_area;
> >
> >       return dma_contiguous_default_area; // null in my setup
> > }
> >
> > and so cma_release will do nothing.
> >
> > bool cma_release(struct cma *cma, const struct page *pages, unsigned
> > int count)
> > {
> >       unsigned long pfn;
> >
> >       if (!cma || !pages) // cma is NULL
> >               return false;
> >
> > __free_from_contiguous will fail silently because it ignores
> > dma_release_from_contiguous boolean result.
> >
> > The driver will be unable to load and allocate memory again because
> > the
> > area allocated with dmam_alloc_coherent is not freed.
> > ...
> >
> > So i started to look at drivers using both dmam_alloc_coherent and
> > of_reserved_mem_device_release and found this driver:
> > (gpu/drm/ingenic/ingenic-drm-drv.c).
> > This is why i included the original author, Paul Cercueil, in the
> > loop.
> >
> > Q:
> >
> > I noticed that Paul used devm_add_action_or_reset to trigger
> > of_reserved_mem_device_release on driver detach, is this because of
> > this
> > problem that we use a devm trigger here ?
> >
> > I tried to do the same in my driver, but rmem_cma_device_release is
> > still
> > called before dmam_release, is there a way to force the order ?
> >
> > Is what i described a bug that needs fixing ?
> >
> >
> > Thank you,
> >
> >
> > Olivier
> >
> >
>
>

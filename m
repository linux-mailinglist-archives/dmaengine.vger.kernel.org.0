Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C3238D5EA
	for <lists+dmaengine@lfdr.de>; Sat, 22 May 2021 15:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhEVNLU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 22 May 2021 09:11:20 -0400
Received: from mail-am6eur05on2069.outbound.protection.outlook.com ([40.107.22.69]:16544
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230431AbhEVNLU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 22 May 2021 09:11:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrURjb3XDUaL7NoJwEhjjFJDdICIewtRwtVJ+YE6050mmwdYWtY7Y5PD74IIcwmg32KZJM33DwhAjVmTAXfO8yXCKu/ro3ih7SMFG5nbzBym0sNMVUEvahCjWEFLB19kiTLE9aDPJ1OyrDS2mPJmuz7ulGWOgBulWhtD0L3NM88Q9yvarr7GdH3uT4x25ZvOeVloH2Zd2CNszdfJ9WUeZCKahG2JhD90HUo8+4+BRPP185voUjt7uvrgq2+0jk9BQdKP6VShQ/0MbgfI+T7D2/RQ9NAPnsimkm3sLslJLxeMUaPz9BtaBp/UImRmOauqY45OoRJPSyQe+SQK2BP3HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lu0doXuivrnPajyggrlYUGgkszfEwAIbjChUAsU+hFE=;
 b=AAE0lnk0d6S7JcbY3o30VeBM2jQCIZuH0NmeJ6WWRI43ECTpQzDIvI7llvtkPBXG5Q8KFAWpFBjd0rKSbDEdujn5GC3F3KJaec/eOvyWW2ayDdPDW5pHbsNfMqnUVpxZyo7IX9rZWybWAcfJVvVk/pkDfNl2JNBrO827rf8/zPVeK/96L5a0/OUB4gpIN7bQlb+wjwifoDYTFQAEmIZk3T0W2ISYJ8seKM2va1mRMESjQtxuqfBuDnwoxRVIwZC/ZmB2uDJP4wG5TR4h+8ClOWXnli3TCn3mWAnl5owa67xHdnfFm0h6FhNngdkXWIGFdTpZuvmnry2IlHbyP1H0KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=orolia.com; dmarc=pass action=none header.from=orolia.com;
 dkim=pass header.d=orolia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orolia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lu0doXuivrnPajyggrlYUGgkszfEwAIbjChUAsU+hFE=;
 b=dFbL7xDUQomg3HmqtQBYqfCzSFzJwfkvMuCfWnhx9GYjXWJFFqM6nxM9uT3bTQN2aRqfT5b46KKujrNSjdNUO8mt+X3HfZ0lqTFVylvyso45aVf4ddqnk511NpXko5Q7RWYUl1YCW9qreMz6qCBi+I53DwxSQzjuQb0yXtr+nrE=
Authentication-Results: crapouillou.net; dkim=none (message not signed)
 header.d=none;crapouillou.net; dmarc=none action=none header.from=orolia.com;
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com (2603:10a6:102:11::28)
 by PAXPR06MB8190.eurprd06.prod.outlook.com (2603:10a6:102:19a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Sat, 22 May
 2021 13:09:53 +0000
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::81ef:de90:c451:d6e3]) by PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::81ef:de90:c451:d6e3%5]) with mapi id 15.20.4150.023; Sat, 22 May 2021
 13:09:53 +0000
Date:   Sat, 22 May 2021 15:09:34 +0200
From:   Olivier Dautricourt <olivier.dautricourt@orolia.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Subject: Re: Possible bug when using dmam_alloc_coherent in conjonction with
 of_reserved_mem_device_release
Message-ID: <YKkCjtFAeBfE9A/g@orolia.com>
References: <YKf4zlklLdfJBN6p@orolia.com>
 <4S7ITQ.ORCLYUEJD8BH3@crapouillou.net>
 <YKjuPtO4NbDe2MLM@orolia.com>
 <SGDITQ.MIZ5W9MRDQOU1@crapouillou.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SGDITQ.MIZ5W9MRDQOU1@crapouillou.net>
X-Originating-IP: [2a01:e34:ec42:fd70:167:681b:bc47:e8b1]
X-ClientProxiedBy: PR3P192CA0010.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::15) To PR1PR06MB4746.eurprd06.prod.outlook.com
 (2603:10a6:102:11::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from orolia.com (2a01:e34:ec42:fd70:167:681b:bc47:e8b1) by PR3P192CA0010.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Sat, 22 May 2021 13:09:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e39c8bf9-e822-44c8-4bc1-08d91d22e33f
X-MS-TrafficTypeDiagnostic: PAXPR06MB8190:
X-Microsoft-Antispam-PRVS: <PAXPR06MB819092E40032F66453DF26738F289@PAXPR06MB8190.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fssvKuuFwwjqPNyux3RwxUkvuH7WGF0RZZg5ouiNMAuF3EaC62CdsoOrIT6TU+1Ee6b6etivFvP6nrERcdjIQqC/cIWa4Ksfudw/GK4lZ7mAtTzpinz0Z98kbJ+NVs3pk8fI0Ja1TRnKWcYg49wHZc4c6hgFHH3gglF/XtQYHcG6j3GeYhPX7QttWioOqNhu91UOZtsOVkmslPXiEnKamMHqm8mMBWq/0ldz1GOJ+jbvilIyd6REGYUupzWgJtpkAR8EyVJ4th8GhJcuLhCx3ezzRpAe3erzjoYGovIbhYxJ0mbjzs39zK+V5VD2TzgQ7dOs0UNcPQSFVRghX4EvjTsl6/6G/jRT/+zPCnjfaIZpSt0qIg9KnVYGxwT1/BdM0yCyOqtQwsaRxDQITbXRJb55oTKS/Se02/9ZNH+JOxgkn/2c1GUNG5NTbSlfVrjdNBqiBYPOkiNAjoPKwvlvB+PM+qkLsSlb89I6CTWyvPQdHCwEpDdEvTu+kI/nMWTGShb/koX+6xARZTmCeVKI8JjT0czHlaamyRKju2THrPOOY6qA3i0s2fCSXyc+AwIKYmYOCfSdIUdVMCYHWIZyHcZe1fqFEIyUEV5VXuHnBOs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR06MB4746.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(366004)(39840400004)(376002)(38100700002)(44832011)(478600001)(36756003)(4326008)(8886007)(2906002)(2616005)(8676002)(316002)(5660300002)(8936002)(6666004)(55016002)(66574015)(66476007)(66946007)(16526019)(186003)(7696005)(86362001)(6916009)(83380400001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bTlRendtalQrU0UxTFVzT3RtbVQ5RDNyZWx3bXMya003V2JMZHFLTWNDc1FU?=
 =?utf-8?B?eXhXdmxrdDE1S25wbFAzM1pVQ1hYdDY0ckdwVnp4QnpLWitEcFdLRmdsRWZC?=
 =?utf-8?B?YTd0K2VPd3lWMWRYTlpkSktidnpzOVd5LzJEaEZGNWVpdGVXUld5VXpjM1FW?=
 =?utf-8?B?eTF2WlNZNThCNnc5N3o5NjJMQnpSVFdOelQvNEdkUjQzYUJ5RGxJY25WRHBz?=
 =?utf-8?B?MDZOTzM5bjBFeDF4NzhFTmtPUmZ6Zi9zanpEQXdHQmZoemd0ZUhna3hNbWdv?=
 =?utf-8?B?QmFuRUhvcmdFTFhqc2duUVZzVENBRXB4MktVMzhkUzBETjFiRkZpU0VBVE53?=
 =?utf-8?B?RkRBdE92Tjk4TGhzeVF1OWFjQ3VmN09rSWpVSnF3dmQ2Q0g5NFdtS011OEZn?=
 =?utf-8?B?Wkd5a2h3SzloNzduejZsNmh3S3h1dG1aMGUzanFZZmlseExveWNlOWZjZmFr?=
 =?utf-8?B?UDNhNTBnaFhGN0thSTE1eitqZ1ZxV3BUZVI5WVVZN095bUlFcXk2NEVkYU8x?=
 =?utf-8?B?ZlBGWGxOY0R0ODBsRGM1UEVOVlRIQjlWdU1XWEUxM1VKbjVEcUI4QTVUVnl6?=
 =?utf-8?B?bkdJMUUwMXNDa2J3SGhqUytJVXVKM2NTM2laK1ZNVTVMWXJvRmw5Qy93ckNu?=
 =?utf-8?B?Q2R4M3dHTmNCWFRQQkRiY3czWWxDTlNBVm5KK2NQYnlUK0JTZGRreGtBdTdq?=
 =?utf-8?B?L3A0QkhiNDFFSjlrc2RvWjlDVTZxWC9xaTJ0L0J1S1FwQmczYVhicS94b2Ex?=
 =?utf-8?B?anl2YXQzbXRxN2d6dEVEWXNDZ0sxZWU2eFVOZjZacTJ4Y0h0SHN0M2trVDVo?=
 =?utf-8?B?UkNzRUtTazhzajlNNjFIN1pQWmlWTElSNUxDMnZJTDY2L2RZSm01US9FK1Jr?=
 =?utf-8?B?NG5qTTNWM2xJTUh2MEtBK3FHbDFxUXE2S250bzd6djBVeG9OZmFSZy8rRzZB?=
 =?utf-8?B?ZTRNTW9CU2xndGc0QlBYWXpSV2d4Qk9ZbGYwYUFZY1FoNms2UEdXNVg1NGln?=
 =?utf-8?B?dW1ZY1liSHR4SDBVTWpqRi9oa3hwVWNjdzBWc1J6Wk42T0twTWlNV214QU92?=
 =?utf-8?B?MUovYkhvUlRaTkQ3TmZLL3AyZ3FBZkVtVExidXlFV2w3ZGNJaVBYSU1Rb2NM?=
 =?utf-8?B?cHF3UEhpYXl4NjI2clpjZTZPelA5c2thSlk5UHJpZVd1RFRLTVZ0Tjl5RGkz?=
 =?utf-8?B?Mld2YzA2UlRkR0pLeVJVWlcxclhCWjE1cGRpdy90clNzYzhTOWdWUlZObmY1?=
 =?utf-8?B?RTRiSmVuZlpHbmlvVURXWWhXemoxSWp5Zno5NkFGVDF5TzlYdHdjOUZpSWFu?=
 =?utf-8?B?eTZGNlhPN0JlZEQvalNheHlXYmdVb0kyazNpMW9mcHVMNXRnUE10ckVkSER3?=
 =?utf-8?B?clZjMWI0RW81RVdoQzRtakFIM2NKRHdydHI5NEpVY25yL1J2amR4UmQvdzls?=
 =?utf-8?B?ZGxCdENXUC9FTjBkM3VyaGg4dlhsbUNwR21jV1FPbjVGTFg1KzgrYXVUcVBD?=
 =?utf-8?B?bE9EZ0ZpbnA2cmYxc25WUjRvNm0zaDZFaUF2Uk1nbnNoY0dndjZZODZFVzFv?=
 =?utf-8?B?WEhFUjVNWU16WkpjY3BKNEhIMDVmWUhESDJkcC9SLzZsUkxQRFBjNXNCMUY5?=
 =?utf-8?B?bFNpRDJKckRGRk94MmFVQVZOODIrcFRQSXdqcnlKZ0NXRjVoS0dQMzJBeFdw?=
 =?utf-8?B?WlhWOWtheldvbEJ5NmlGQjBtRFVIbUlCWUdwUTJ5MmhwTE04RmZwYW51ME9r?=
 =?utf-8?B?OGV6akFYWWtUdTNPeEp5N20ySnUwOTcrRDVBbHN4TVJid3orWWhrUC9XUXI1?=
 =?utf-8?B?VmNMK1cxbzEzaU8rYVhjYzFxUG9pVEpsa0VQZEJNYTcydTN0RG9FWFl1anRw?=
 =?utf-8?Q?8ay25mOtD7GVj?=
X-OriginatorOrg: orolia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e39c8bf9-e822-44c8-4bc1-08d91d22e33f
X-MS-Exchange-CrossTenant-AuthSource: PR1PR06MB4746.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2021 13:09:52.9964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a263030c-9c1b-421f-9471-1dec0b29c664
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4UHmZEpu/YJduJUZzQfg5GelQfh1UGu+jJlYQX7OhW51jDVoU4J2ZlXAArXgpchXivfZoG3ThW3m0M53pPKLKrC+Jsz6T6g304yjWM4MM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB8190
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The 05/22/2021 13:31, Paul Cercueil wrote:
> Le sam., mai 22 2021 at 13:42:54 +0200, Olivier Dautricourt
> <olivier.dautricourt@orolia.com> a écrit :
> > Hello Paul,
> >
> > The 05/22/2021 11:28, Paul Cercueil wrote:
> > >  Hi Olivier,
> > >
> > >
> > >  Le ven., mai 21 2021 at 20:15:42 +0200, Olivier Dautricourt
> > >  <olivier.dautricourt@orolia.com> a écrit :
> > >  > Hello all,
> > >  >
> > >  > I am facing a problem when using dmam_alloc_coherent (the managed
> > >  > version of dma_alloc_coherent) along with a device-specific
> > > reserved
> > >  > memory
> > >  > region using the CMA.
> > >  >
> > >  > My observation is on a kernel 5.10.19 (arm), as i'm unable to test
> > >  > the exact
> > >  > same configuration on a newer kernel. However it seems that the
> > >  > relevent code
> > >  > did not change too much since, so i think it's still applicable.
> > >  >
> > >  >
> > >  > ....
> > >  > The issue:
> > >  >
> > >  > I declare a reserved region on my board such as:
> > >  >
> > >  > mydevice_reserved: linux,cma {
> > >  >         compatible = "shared-dma-pool";
> > >  >         reusable;
> > >  >         size = <0x2400000>;
> > >  > };
> > >  >
> > >  > and start the kernel with cma=0, i want my region to be reserved
> > > to
> > >  > my device.
> > >  >
> > >  > My driver basically does:
> > >  >
> > >  > probe(dev):
> > >  >       of_reserved_mem_device_init(dev)
> > >  >       dmam_alloc_coherent(...)
> > >  >
> > >  > release(dev):
> > >  >       of_reserved_mem_device_release(dev)
> > >
> > >  You must make sure that whatever is allocated or initialized is
> > > freed
> > >  or deinitialized in the reverse order, which is not what will happen
> > >  here: release(dev) will be called before the dev-managed cleanups.
> > >
> > >  To fix your issue, either use dma_alloc_coherent() and call
> > >  dma_free_coherent() in release(), or register
> > >  of_reserved_mem_device_release() as a dev-managed cleanup function
> > >  (which is what my driver does).
> > >
> > >  Cheers,
> > >  -Paul
> >
> > as i was saying in my previous mail, i tried to register a devm action
> > to trigger of_reserved_mem_device_release on cleanup but it was still
> > called before dmam_alloc_coherent_memory's cleanup.
> >
> > So my question is: How do you make sure that the managed cleanup
> > routines
> > are executed in the right order ?
>
> And when exactly do you register the devm action?
>
> If you register it right after of_reserved_mem_device_init() and before
> dmam_alloc_coherent(), like in my driver, it should work fine (provided
> your .release doesn't call of_reserved_mem_device_release() itself) and
> you shouldn't have to do anything more than that.

I'm unable to test right now but you must be right, i registered the
devm action after dmam_alloc_coherent, so i suppose that if i change the
order it will work...

However i am still wondering if it is ok for the dmam release
to depend on the reserved mem state to suceed.
I think we should at least issue a warning when  __free_from_contiguous
fails.


Olivier

>
> -Paul
>
>
> > Should we have to care about that when using a managed
> > function that belongs to the core ?
> >
> >
> > Olivier
> > >
> > >  > On driver detach, of_reserved_mem_device_release will call
> > >  > rmem_cma_device_release which sets dev->cma_area = NULL;
> > >  > Then the manager will try to free the dma memory allocated in the
> > >  > probe:
> > >  >
> > >  > __free_from_contiguous -> dma_release_from_contiguous ->
> > >  > cma_release(dev_get_cma_area(dev), ...);
> > >  >
> > >  > Except that now dev_get_cma_area will return
> > >  > dma_contiguous_default_area
> > >  > which is null in my setup:
> > >  >
> > >  > static inline struct cma *dev_get_cma_area(struct device *dev)
> > >  > {
> > >  >       if (dev && dev->cma_area) // dev->cma_area is null
> > >  >               return dev->cma_area;
> > >  >
> > >  >       return dma_contiguous_default_area; // null in my setup
> > >  > }
> > >  >
> > >  > and so cma_release will do nothing.
> > >  >
> > >  > bool cma_release(struct cma *cma, const struct page *pages,
> > > unsigned
> > >  > int count)
> > >  > {
> > >  >       unsigned long pfn;
> > >  >
> > >  >       if (!cma || !pages) // cma is NULL
> > >  >               return false;
> > >  >
> > >  > __free_from_contiguous will fail silently because it ignores
> > >  > dma_release_from_contiguous boolean result.
> > >  >
> > >  > The driver will be unable to load and allocate memory again
> > > because
> > >  > the
> > >  > area allocated with dmam_alloc_coherent is not freed.
> > >  > ...
> > >  >
> > >  > So i started to look at drivers using both dmam_alloc_coherent and
> > >  > of_reserved_mem_device_release and found this driver:
> > >  > (gpu/drm/ingenic/ingenic-drm-drv.c).
> > >  > This is why i included the original author, Paul Cercueil, in the
> > >  > loop.
> > >  >
> > >  > Q:
> > >  >
> > >  > I noticed that Paul used devm_add_action_or_reset to trigger
> > >  > of_reserved_mem_device_release on driver detach, is this because
> > > of
> > >  > this
> > >  > problem that we use a devm trigger here ?
> > >  >
> > >  > I tried to do the same in my driver, but rmem_cma_device_release
> > > is
> > >  > still
> > >  > called before dmam_release, is there a way to force the order ?
> > >  >
> > >  > Is what i described a bug that needs fixing ?
> > >  >
> > >  >
> > >  > Thank you,
> > >  >
> > >  >
> > >  > Olivier
> > >  >
> > >  >
> > >
> > >
>
>


Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5DD372B5C
	for <lists+dmaengine@lfdr.de>; Tue,  4 May 2021 15:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhEDNw3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 May 2021 09:52:29 -0400
Received: from mail-eopbgr30052.outbound.protection.outlook.com ([40.107.3.52]:31392
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231127AbhEDNw2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 4 May 2021 09:52:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAgIeTHgCMC2rHWiZEy24wjlf7cvKgP38waCnxcg5lrzqbj8pBZ8rzA2Z+7Xu3QDQssY7t4DdGDXjDhAIDlFrnJ2E63C7F2PmOfeyLKJkx7WfmSke0Vr9wgJkPrcQVei9k26KaA+7ynQT1LgWnNrTGC54YJkxgp/BrX9Pon/atPHIj/czCPmis+OWYtBk51unnJZGpDhV6pAL8TeY9uH/jcGA9i3cqId4V5cxn2uLPF+xeLJxnC7CvkD9lAh7KbhoerRuxTAmCyT2ApKp9bDuKG8NXqNjRD3Ya//EV4YLrEA4b8bTu54hmISHRodwKXD1CBRigUyVtvYrHKb63M5ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHku1Ausdu8LqhRjXFV92tGxrGzBKu0j1o7Xq68aSKw=;
 b=VQiDK2oKsXymCdSxv+iggjAKTB4zqBCK55U3MQ1f778fKiZVVHi8l2HWtbyWbCgusJQ97EnkEMEC0Gr2IdCrLePfZ2wNmTk27KrxcxH8NptV+W00goGlpFd18qBu0h9mFuOcHnO56Td4EaykcZ5AK1Yi2EHgwkhU+LJEH4JwAP+C2BnYVhLznizs12QEjlnwTRP8KPAStyYpJ2KxhPQkeL+ychvbfyWUwRu6jKKqugf+Dh6HSU+hHzzgR/dmj/j2dNYzmLernoqCVoPC/KGgHwBm1B11GvRi/Kqled6SzpOLEOBRfLceLaKZmY6FsZ+RVNWCC8z70eLs59nmAuinxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=orolia.com; dmarc=pass action=none header.from=orolia.com;
 dkim=pass header.d=orolia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orolia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHku1Ausdu8LqhRjXFV92tGxrGzBKu0j1o7Xq68aSKw=;
 b=p2qUv2ehIDMK8RF68Lj4gnLx8GKk/dJfpQlAxeOHqFSvbk5nVt4gocRFjK1+gXOjfoWUCphFs7w+nLs/qbX6ItOasvw9KzZpTFA1QzyHnMsquDtMX4rkjoWJC82PNcquHNEQhu2J3pQTlvIgzrNCAp1VVmS9rnA8wLfo0QLeUwg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=orolia.com;
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com (2603:10a6:102:11::28)
 by PR3PR06MB6666.eurprd06.prod.outlook.com (2603:10a6:102:6a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Tue, 4 May
 2021 13:51:31 +0000
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::81ef:de90:c451:d6e3]) by PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::81ef:de90:c451:d6e3%5]) with mapi id 15.20.4087.043; Tue, 4 May 2021
 13:51:31 +0000
Date:   Tue, 4 May 2021 15:50:44 +0200
From:   Olivier Dautricourt <olivier.dautricourt@orolia.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Stefan Roese <sr@denx.de>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: dma: add schema for altr,msgdma
Message-ID: <YJFRNEgNZlM8yKXk@orolia.com>
References: <YIq/qObuYw+8ikxg@orolia.com>
 <CAL_JsqJc=EDhXNcb4QZbmD1Ukh94hqLhk4YvN4SoCdt32TGMSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL_JsqJc=EDhXNcb4QZbmD1Ukh94hqLhk4YvN4SoCdt32TGMSg@mail.gmail.com>
X-Originating-IP: [2a01:e34:ec42:fd70:167:681b:bc47:e8b1]
X-ClientProxiedBy: PR3P189CA0043.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:53::18) To PR1PR06MB4746.eurprd06.prod.outlook.com
 (2603:10a6:102:11::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from orolia.com (2a01:e34:ec42:fd70:167:681b:bc47:e8b1) by PR3P189CA0043.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:53::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Tue, 4 May 2021 13:51:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84f10a4b-a825-42ef-43e2-08d90f03b8b2
X-MS-TrafficTypeDiagnostic: PR3PR06MB6666:
X-Microsoft-Antispam-PRVS: <PR3PR06MB6666307F99CD3CED1E867D618F5A9@PR3PR06MB6666.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vK084PDDLJ5e6G1AMvfLqkn9/lxLaOiwVyNgG1ZoieA4XMfoRVNztnO1ipd7N4HTFXcXAJ8pF+dwYwmqypFAm4Ch40T4veTVE8Sm5ODPKiKJxpt6ShoVIeP0fPgyhlt7IsEBli2yVpia5BlwSdGIE5BbBl+x9+vqwVhTmAHPANROvJLa5MHmBI8SFkOHRYsI38nSy+7Gft7iBl1TOtLsRLNDsS/PvSHuSbvqQ+98aD/FHX7FJm7BrI8XJ84preOilWkWbYEtBw+YmnNXBW+uRaHjuJ2l45UmiuE1u1VfPPFuHtjUz9elcuPEPM3NjHwIkfPnD0mN9/c2s9aI0BpqEE7HGdWZTiF2I3WhPD46MaACCUO3YJ5ODAW5oOozDmDjo2wrmCKhsVABDs47pKaIbyTi64bS5CRiFFpE0zYX6RadCsMwpTIimXPFTOyt7wDIEiBHaUHCeULOIYzbNJ7lIN9FO+6uQwQhl3rS3hLlGQV7wUho7x/sgIXUJr2d9YsfW/WyIJwRX2DH8gae+pTTETpLeFQyakMWlto54eFLSoTvv0Lbib4pSwuGbD3O7QrYttBBz7gSSGyvxPqu4fYZMZA+pK6uJbDb16PTjC2f1xtk74nmp6qsgP9sN9Ail737CX+G7rPwQ9ixhaglBCgFB8yNIuwhoc28vqcbpmpya9Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR06MB4746.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(396003)(346002)(136003)(366004)(376002)(66476007)(966005)(53546011)(66946007)(6666004)(478600001)(66556008)(4326008)(44832011)(83380400001)(55016002)(316002)(36756003)(8676002)(5660300002)(7696005)(8936002)(54906003)(186003)(8886007)(38100700002)(86362001)(2906002)(2616005)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?THFhNmhvSTJob3VKQmhsTDNRc0lBR2dCMFZuWWlXRXRmWU1yQU1oQmZqUUFD?=
 =?utf-8?B?Y0tpU2syazB3aGJEZE1YbStvZDdyMWRqWi8rNjhYTk9rdEZSSFdyNTRDVSs2?=
 =?utf-8?B?TStPb1YveFFNeHlIbTdKVUNTeDdCQnEva3liaE1EN2VwNy9nWWhibWV4V1hN?=
 =?utf-8?B?bFhCOGxqWmRCWkxjTjlzckkxNTVsTk00NHpDYy9OaTliRHJqVnllblIwTWtW?=
 =?utf-8?B?UWhDVlBZdVZ0bGpna3BGaDRtSllSTWh5WlpOeXRBQ2ZCSWNLTkhNTXRCM3N2?=
 =?utf-8?B?UnVFQ1M3bjFjZVMvRTRyOVVJN1loWU5JR212cGI0bWJzYlgzMkNFZ0g5M00v?=
 =?utf-8?B?SEZzUFNBWFRmZEdKVUNla1N2UTkzbWs4S2swa3pZUExUWTBCUzNzenZaUzRC?=
 =?utf-8?B?SlBleEVxSkhHc0NZbm9zaWppc3NXWnlKclBidTNCNTFaUUtIM0VXZkE3MWhU?=
 =?utf-8?B?d3NwWTJwd1JGbGhmN2FibE1pdTE2TkIySktEV0FwMGYrd25qMXhOblJXUEQ0?=
 =?utf-8?B?aUlxU3E0eTAzajNMSm1sUk1xMlZGeG1ROC8vaCs2U09XLzRqd2I0VWs3eFBI?=
 =?utf-8?B?aFU2dnhpcytBNkovc040dGtPSHluc1BUNEZKZ0h2cHIwQ2tLY1Q5OXlqNVNi?=
 =?utf-8?B?dFRPakVPQm0yR0NtWTAyd2hlR3liYjE3eVVHZldwbTZuTEVRWEFjc2VtZFJl?=
 =?utf-8?B?dmRFQVlGOG13NGkyRHV1VXJRQVBxMVpMZ0RoSjZmMXdCaVphN3JoTXpBdkJT?=
 =?utf-8?B?QUdSUEplVnYvWXdMSEZOMmZEWVErODZUQ0l4VlBLVHJjZ0ViWVNiRWxYQU1k?=
 =?utf-8?B?eStmdW94VUVtNW9pTk5razlUU0t3OCs2ZkhuWDJXTVdWSlBOR3laQ2JOeFhC?=
 =?utf-8?B?Nm04ZDhaRThmQldpajUzU0Z6UEJRNzk5UldRZDZ1dXErSzBQa01wdGVvMit1?=
 =?utf-8?B?NFI5WGh6UENTeFE1VllIR2wxRGgyRjRUSnBqbkNjcjBzZ3RiUnluTEVmeldC?=
 =?utf-8?B?aWhXaUJ2VXJHd1FMdFpCTFlMRm90dlZKUVZHUC9RbWg0L1RNUTgwdWRZRzNu?=
 =?utf-8?B?WmtCY1g4alQrcm1jVnVvV0UvdGpCL2lCeEJ2bzRwWEhKVEtOTTNDNW5MNnBO?=
 =?utf-8?B?aSsrRXBPSmQxZUFydzlSMEgxWGVjZExqVTVOOWxOWnF0UlNlcXVVT1pNTDVp?=
 =?utf-8?B?RzJXV0JOdjFHeDlNQVlMTmlvVjZFRnVobS9VNDAvRkpvTi9zaTlxTU5nWlRE?=
 =?utf-8?B?djY2VmZHckZGK2dKUzhSYzZBTTc5VjNVamkzV1FQVmNISnhRRy9PMDQxQndo?=
 =?utf-8?B?Sk9ERTJuaXZYMURTTFJHdENSMjRNZ0xUNlhyOGc2aENlUlFRY3pOVEZrQlNz?=
 =?utf-8?B?ZFRMU0Y4dG11dnRoWU5BNVplVU9iUVAyc2VKVWFUQklRYUFVSUgvczFBNkh4?=
 =?utf-8?B?ZDFGNTlIM1lnczIrZDJualAwNDVpbW0wSWxLR1N0eXEyOUlTeVBZMllQNDI2?=
 =?utf-8?B?ak9MbVRSZTE0eTAxMmVvMG5sSm1UUWc3azNVQjdxandaR3hyUWJaOGh3Q1pB?=
 =?utf-8?B?YmFmRWN4VXV0blE3MzhDQjYvLzA5bjlYazZRWEtOcko1VjdIZkNSMnBOYzZX?=
 =?utf-8?B?bVRCQklxTWk5MXpaa0RNRWV5OHFYeGV5NXhkZXdaUk0rbmdoOTF6eVE3STNF?=
 =?utf-8?B?TjJSYnJrWU9zSVFIMVlENFVtRTFBVHQrempWNXpHb3lRNmdYaFl5eEhGOEE4?=
 =?utf-8?B?ME1VTEtKczBvUkhvOU5pUG5PSXRzS3Yrb3pVVTdlbFk5T21VMmxVME5XTnlV?=
 =?utf-8?B?cUNkck5UMXZPZG5iMVlpRzZPUlJkT01WVm5USlhQcE1uQlJuZWN4eXZZNWQy?=
 =?utf-8?Q?LiyDWkrSPxJTn?=
X-OriginatorOrg: orolia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f10a4b-a825-42ef-43e2-08d90f03b8b2
X-MS-Exchange-CrossTenant-AuthSource: PR1PR06MB4746.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 13:51:30.9114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a263030c-9c1b-421f-9471-1dec0b29c664
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4M66/iYbtsHh7udgasGa14gHM/F4xxIk6Fg27PB/7lZ2o+94i3H4VX6fRg/aMDtG4M9DKptcTZcEOdnhh+o5y5G27D7/C2HLHr6F3wkwHGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR06MB6666
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Rob,

The 05/03/2021 17:06, Rob Herring wrote:
> On Thu, Apr 29, 2021 at 9:16 AM Olivier Dautricourt
> <olivier.dautricourt@orolia.com> wrote:
> >
> > - add schema for Altera mSGDMA bindings in devicetree.
> > - add myself as 'Odd fixes' maintainer for this driver
>
> While I guess valid, the tools (b4) don't like the '/' in your
> message-id. Lore will escape it fine, but then you have to escape the
> url. Would be nice to avoid all that, but maybe this is Exchange's
> doing?

Yes it must be Exchange's doing, i'm not sure if i can
configure this but i'll check.. Thanks for noticing.

> > Signed-off-by: Olivier Dautricourt <olivier.dautricourt@orolia.com>
> > ---
> >
> > Notes:
> >     Changes in v2:
> >      - fix reg size in dt example
> >      - fix dt_binding check warning
> >      - add list in MAINTAINERS entry
> >
> >     Changes from v2 to v3:
> >      none
> >
> >     Changes from v3 to v4:
> >      none
> >
> >  .../devicetree/bindings/dma/altr,msgdma.yaml  | 62 +++++++++++++++++++
> >  MAINTAINERS                                   |  7 +++
> >  2 files changed, 69 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dma/altr,msgdma.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/dma/altr,msgdma.yaml b/Documentation/devicetree/bindings/dma/altr,msgdma.yaml
> > new file mode 100644
> > index 000000000000..295e46c84bf9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/altr,msgdma.yaml
> > @@ -0,0 +1,62 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/dma/altr,msgdma.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Altera mSGDMA IP core
> > +
> > +maintainers:
> > +  - Olivier Dautricourt <olivier.dautricourt@orolia.com>
> > +
> > +description: |
> > +  Altera / Intel modular Scatter-Gather Direct Memory Access (mSGDMA)
> > +  intellectual property (IP)
> > +
> > +allOf:
> > +  - $ref: "dma-controller.yaml#"
> > +
> > +properties:
> > +  compatible:
> > +    const: altr,msgdma
>
> Needs an SoC specific compatible.
>

It should be compatible with altera's socfpga family.
Should i leave a general compatible field such as "altr,msgdma" ?

example:
  compatible:
    enum:
      - altr,socfpga-msgdma
      - altr,msgdma


Thanks,

Olivier


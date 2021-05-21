Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B5E38CD0C
	for <lists+dmaengine@lfdr.de>; Fri, 21 May 2021 20:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbhEUSRW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 May 2021 14:17:22 -0400
Received: from mail-eopbgr90058.outbound.protection.outlook.com ([40.107.9.58]:60592
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231193AbhEUSRV (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 21 May 2021 14:17:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3X6VxokOouotPSwzohvmc8WBJLVGRc1/preAFmPztG+9kRgfIGjQRiP8N9Wt2SGuQUC4laHQ79SKalebnvdJcep72/yaUQZjBlKfcGOgEDLWFKznP+9eoVebISZXEy+vOG+CTIvEiojC5KlYtyW72pW9RXuZYgXD3D7rP7g7QSfun0cvfoko+Q0JC9K3jnOz1+rVT1bftPnf7ja0oMZH+b9ZrkCYcTEw0XFjM0E2SLF4tWPmXKO9W9Af0dIFTQAPf3VBJCJ32rwC6Ao2pZFgd6WXZLgUTDXpoy7s6LfgwEmCN4eJL2qAzLbbTDNg1C/9J0X8RcOCnFdp9Cww9TU0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/x+ddI5J+nxb6FubNXq5c7eNh8Unbl2ureUEmLwp9Y0=;
 b=N8xMyZlykwP1aYociYLYEnRZ/Kqdjtq2nNoQt6SBBmu0pJjFy9RzmXGsu04El/ylWfaPtmVeHKEYlMn3qYQfPrG1GySonbwwbcU4X3X4cTzoBwm7ycyZqQ9+5FcdCWQ6vpvcVA52KPjZgXD1Lb5oCVXzwoFQnVfHBridxvD3N0I64dW2qmob3FzxeZrruyGt0W7iGJIE0cNgdmoYZMGyGLXUPTUoBuSstI16Tur0vgoBTnR3lE7kj7gINhO7D1RtleqIZCf+CfBKxOaKYJfjgckp8w6utrJklmV+Nw+R7GacVYx31gNaekJDMHtWv19e46+M+cyL8qMx6x3UvA8CvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=orolia.com; dmarc=pass action=none header.from=orolia.com;
 dkim=pass header.d=orolia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orolia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/x+ddI5J+nxb6FubNXq5c7eNh8Unbl2ureUEmLwp9Y0=;
 b=YG7cfPit4JMGXeoK1TLNmEkSKubnp1eqTSdmichUndhO+J9ihhDa/5UFxiYjkf1RSPHCrtnWmAafItBhhlaPEOS9QefOIvhdKrx/QC8/zHLfoPL/qVG6W8NEVCc4oZsUcrOt3XC4Jr+C63oWgL1YP+5opgFGGUBBGd4KJ2KTc38=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=orolia.com;
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com (2603:10a6:102:11::28)
 by PR1PR06MB4681.eurprd06.prod.outlook.com (2603:10a6:102:10::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Fri, 21 May
 2021 18:15:55 +0000
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::81ef:de90:c451:d6e3]) by PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::81ef:de90:c451:d6e3%6]) with mapi id 15.20.4129.033; Fri, 21 May 2021
 18:15:55 +0000
Date:   Fri, 21 May 2021 20:15:42 +0200
From:   Olivier Dautricourt <olivier.dautricourt@orolia.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Olivier Dautricourt <olivier.dautricourt@orolia.com>
Subject: Possible bug when using dmam_alloc_coherent in conjonction with
 of_reserved_mem_device_release
Message-ID: <YKf4zlklLdfJBN6p@orolia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Originating-IP: [2a01:e34:ec42:fd70:167:681b:bc47:e8b1]
X-ClientProxiedBy: PR0P264CA0188.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1c::32) To PR1PR06MB4746.eurprd06.prod.outlook.com
 (2603:10a6:102:11::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from orolia.com (2a01:e34:ec42:fd70:167:681b:bc47:e8b1) by PR0P264CA0188.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1c::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.24 via Frontend Transport; Fri, 21 May 2021 18:15:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 629b9044-e528-43f8-96e3-08d91c8479b8
X-MS-TrafficTypeDiagnostic: PR1PR06MB4681:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PR1PR06MB4681DCD6EED6535ED8BF8CC88F299@PR1PR06MB4681.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iiTBUyHQ6vhWOm9o4q2OPKQBjcYlpy0RnM8UwBTrFyQqIRu1WyU7JbrmvdxgtGAupOaWv2Hbt79l7mDUGo+RWZsGQrmv+WS5VpSjQ/deQ6L4VH3IMevfUURkQsAQmrM5gf0ymzAYGaqE52G2EoPH13UDQKM5qKcREQewkm6UeVKpIaKxWwkOZIokpKbcBAdq8hFvhQXysDfS+D/nTR6APVTVYTbWF3CbGz8n+T3oPZbSCq8mRD3d2a9StQolPcKi5CB2z1Vtf+35ywhzHwD4vgngY57cWf871ugkCP/ph6mo0dXCDJ5KLyn4RCWDXCAKGsoe36Q9yp+9yTLj7IRVskZ9ApTfn9WX0gbxK97slGWnv+V1CroKw1dUiPkt1/waHpYEn3LfT8nFPvQNmZoYPGD24hmG3DatBHZawT3rmxFAHgT1X4wKND52l27x8RvKC2X7zaKr61Sf3pOsMTy8r83gxYSMrWI5i/xjZAK5EApDMTnjkqNMh7H4XQ/sgzQAIjjgfiKa/U3Vrcpkut3wmZKq69Iyo6y8psUQLuAYlIXYIPfJ6dk0+aD6xKpfwCW3clP+jysLeCUZduDzkd4S0XFR90Bn9UKXuDvmod0dzEI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR06MB4746.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39840400004)(376002)(136003)(366004)(8936002)(38100700002)(2616005)(44832011)(83380400001)(55016002)(6666004)(8886007)(316002)(4326008)(86362001)(8676002)(107886003)(66476007)(66556008)(66946007)(36756003)(5660300002)(2906002)(54906003)(478600001)(186003)(7696005)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?90ny8JuNdhaNQ24QDkFZ3ztol/dCD2l4YKeqJC7Wce8mCFYl6s5M2euTYkfW?=
 =?us-ascii?Q?K3qSMoNA5k9QVxShLwqxvV1ayM8UYfMbUufUyn7L3bSQI41I+2YW0gB8aJ5v?=
 =?us-ascii?Q?z4byIMOxIf2jW4DJV46RjWd87ra9RyxPBMWczrxwfT/uZ/RokyyA/MOJ6mRb?=
 =?us-ascii?Q?9eCHb4+CboEDgO/oFXG7I5LfpDZ7/xAZgsGWRFDwM/Xx0XwblAhl4PmoUhCO?=
 =?us-ascii?Q?Pwcq2hr8YihtjLrD0CkmuvUJqAcOV0FRCC4Ks2h2HDdyi7fkHMbULAoAklCX?=
 =?us-ascii?Q?vNfWwjFA9X1URIV4A+IzUzi9pHsj418HIpgAZGsJh+436GAP+lIyX09lfES1?=
 =?us-ascii?Q?5XbdMBG/IxusuDsWfWRqtifI/PdH3tExiObcdFvEyJvLUQLMxIcnuKb508FV?=
 =?us-ascii?Q?w/raqIInt+1FcC4TivEyJSkx16M9hBLihF9WUkDjwnUZEYuRtAjWagp+2+35?=
 =?us-ascii?Q?5Hykjs47FFgB7CKQIrxuz9KFkgEmKFAZyqj1w0f3fn/nZuejkainVol8wN/u?=
 =?us-ascii?Q?SEXB+iVkolsCRAIwgmh3wWS0p7xAWyCXGCNwc2byrPGHaDg888cnO43Y7mjv?=
 =?us-ascii?Q?bNlStei12hTNfZGWDurmXxw/aIqQKABFOvUrJooliMVqvozDAbPUx19lDS8Q?=
 =?us-ascii?Q?zfllKwZLntMzbXV8ZJLUxybFMXvLiSxaqxSqdsFx7DCg/qa7a/aMYGAxE8MA?=
 =?us-ascii?Q?uipNfsRP+lIXdXpAO3NXTeBWV/sRz7A0XvTXXfZwq3egf12m1XB9GMtcyFB8?=
 =?us-ascii?Q?GU08hE+zmXe2m0t3wr4Rk4OrNQAaXyP24HVGjJc0APXFaDbNXjC/sa/OU8NV?=
 =?us-ascii?Q?UaQNGPtMxgSUdetHCjxLefjU3P2G0F+MedcNoiFSxYQgDmPpbpDcmSEyASze?=
 =?us-ascii?Q?ba08ok9c1vHfnC+zoK7yh/ydfoS5cZg8mX5fSoOG+2LW3+yRnk02LxPD6aRf?=
 =?us-ascii?Q?MGCYt5TdmT0cBnLy4CPbNLlVO8aTjqTWiZlvZXkwIhbB1/cKP5PNL4ihTL7I?=
 =?us-ascii?Q?9+QM9/NTlU9Zq9iOmGdruD3HCMMzqtM206msfuO9CHsK9kNm85u+NamjJwXi?=
 =?us-ascii?Q?9EJTPVG/9JQA+PCXUz5ewY35OIxKiaykZgVNH+VlEbZ63YPI3fs7ycTUkBdB?=
 =?us-ascii?Q?A6nReg2m57/NQcisqnTCHpTygKkz0SWx7bbGOidDlXrzpeow3ItDer+Ic9zW?=
 =?us-ascii?Q?sL4wgxbBJuk3ICOI4d5FbOZSSH9ZO7P/eNE2vfwM+lhtGoCRqXtmlg9PzzEw?=
 =?us-ascii?Q?6aGjH2aAH09KNx0vNUSxVURpM9N7u+aPQ+yqDrQARH0ZAxzhZ/f0uAIWMZXk?=
 =?us-ascii?Q?wW0K/eXRawiPhZW5ageSxd+yGsFvj1ZG/vPQ5EOuEuCpz7g0J5vW5nVCnP0g?=
 =?us-ascii?Q?HF/absfgy4dpasnT5H/ud43GYVbu?=
X-OriginatorOrg: orolia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 629b9044-e528-43f8-96e3-08d91c8479b8
X-MS-Exchange-CrossTenant-AuthSource: PR1PR06MB4746.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 18:15:55.4096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a263030c-9c1b-421f-9471-1dec0b29c664
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2cDQg6f2iF6IVVbG2mMBL+x4WhHQ4w6MO4Fml78E+H+j9a11woDCafIFDkxaIZXZ+dL6z8cFw5xX5Ws9E0joBnv68cjadMBO3T3Y+dsLRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1PR06MB4681
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello all,

I am facing a problem when using dmam_alloc_coherent (the managed
version of dma_alloc_coherent) along with a device-specific reserved memory
region using the CMA.

My observation is on a kernel 5.10.19 (arm), as i'm unable to test the exact
same configuration on a newer kernel. However it seems that the relevent code
did not change too much since, so i think it's still applicable.


....
The issue:

I declare a reserved region on my board such as:

mydevice_reserved: linux,cma {
        compatible = "shared-dma-pool";
        reusable;
        size = <0x2400000>;
};

and start the kernel with cma=0, i want my region to be reserved to my device.

My driver basically does:

probe(dev):
	of_reserved_mem_device_init(dev)
	dmam_alloc_coherent(...)

release(dev):
	of_reserved_mem_device_release(dev)


On driver detach, of_reserved_mem_device_release will call
rmem_cma_device_release which sets dev->cma_area = NULL;
Then the manager will try to free the dma memory allocated in the probe:

__free_from_contiguous -> dma_release_from_contiguous ->
cma_release(dev_get_cma_area(dev), ...);

Except that now dev_get_cma_area will return dma_contiguous_default_area
which is null in my setup:

static inline struct cma *dev_get_cma_area(struct device *dev)
{
	if (dev && dev->cma_area) // dev->cma_area is null
		return dev->cma_area;

	return dma_contiguous_default_area; // null in my setup
}

and so cma_release will do nothing.

bool cma_release(struct cma *cma, const struct page *pages, unsigned int count)
{
	unsigned long pfn;

	if (!cma || !pages) // cma is NULL
		return false;

__free_from_contiguous will fail silently because it ignores
dma_release_from_contiguous boolean result.

The driver will be unable to load and allocate memory again because the
area allocated with dmam_alloc_coherent is not freed.
...

So i started to look at drivers using both dmam_alloc_coherent and
of_reserved_mem_device_release and found this driver:
(gpu/drm/ingenic/ingenic-drm-drv.c).
This is why i included the original author, Paul Cercueil, in the loop.

Q:

I noticed that Paul used devm_add_action_or_reset to trigger
of_reserved_mem_device_release on driver detach, is this because of this
problem that we use a devm trigger here ?

I tried to do the same in my driver, but rmem_cma_device_release is still
called before dmam_release, is there a way to force the order ?

Is what i described a bug that needs fixing ?


Thank you,


Olivier



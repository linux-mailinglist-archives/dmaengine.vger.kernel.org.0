Return-Path: <dmaengine+bounces-6809-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B136BD16C1
	for <lists+dmaengine@lfdr.de>; Mon, 13 Oct 2025 07:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44A301895C99
	for <lists+dmaengine@lfdr.de>; Mon, 13 Oct 2025 05:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD212C21D8;
	Mon, 13 Oct 2025 05:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Q2glnHGq"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012009.outbound.protection.outlook.com [52.101.53.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C242C15BA;
	Mon, 13 Oct 2025 05:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760332682; cv=fail; b=JY38eSUSn9Afh+uKG1mXRs60PHYUVbZ7zuqvkcpUPLE4mCZddl1Su3QVzoTwpsi00ONkMN4jTj3/hPdbJF/x2AAM7AMXNoAXi7nu1+ZmWhGG3u/nKl2fhpHH+cY7lJo5jg7cAHHEC9ssGBjwoU2BSJTgAOmXOxeDog0icna9Ccs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760332682; c=relaxed/simple;
	bh=l/+qtGY1R89HFhg6Us8kZsHbXQ9fqD3rfpbwoVJeJBs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=osvQ4GsswhXia1kyemH7ZHortVjfs1H38dZzXg0CKgH/RG2FProD0m7ZQi5cy/eArnqPIg/CxtA7SHwXxA8R9CJY+L+ry6obJnXiLJEsyHkdGtm3+bARlRvD6QYsVEhc37Zqtxzo0T6s/1TosRKFp/j6CxapUHTvm6sS6SIkRws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Q2glnHGq; arc=fail smtp.client-ip=52.101.53.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wj/186PRrjW7VU26B5hedfCyyxpaTgYEtd8kknu4m0ukdFVo26wkzOznX0EV/3aXROfydvZR4Ynq5l15DE/x0LV9fFLho4TOxQsMOYYV6tvQ/DwmKPR1HWYaTe6fLmBdceQXgIwRrYYkxlsCznkyGhUjVdtron6B0q+Bja3aSjM9D6/eF9gtqS8WkaJA4mMmqekeD/AUO3yw0vngOv6umdpvKSn9lN/CAiYuNb+AkNy4tt7RJAdki/1dK8G16Zb7U0K9pzqyLaqaWAoXvVonRDOqqmWENAbExBzOh3ULTfocUz7awQjgq9QW1yKW24W+4t+J0JOasrBSA7Qn/SUfIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ik5hatzXUAAK4T2FJ8nlpCuJCxlGelUwJ6gGs0Hohrw=;
 b=h+tYj/OYGbi14WmB8p8c1lP60NImu7WqouLv4C/tC4XglDevVZgwZ0PJYX76B/twSONnEwC6DVOYk2cd7c4G2pEboO2yBrWVRnhAIagW9pX4FLxqRvpToNqxib+vY0TDa+0fwnBYqF2sm4qmfYTGO0FfxIs2Y2/rdk2R/bzIvXASGYJ/gUBYFSiNFZy+cVVEVahN8k4OUZt5OrxCpIlToeNxuNds/S7foST2apcTCm8VGxX9XFtnDp8eDOKGDRlDLEnNrRos/IXX0OYiza8QXI34hxJkHb9MXi17M/81BBeXvYDBsF492IR2pDfV0NY5wxLT9HIbjbKiGvdLAhmR9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ik5hatzXUAAK4T2FJ8nlpCuJCxlGelUwJ6gGs0Hohrw=;
 b=Q2glnHGqtSr5Wu2UO5FTQmepg/B3H9oX8LtLiAyFZ1/GdL0EEJJRPdHoQh/IodPytfu47nqjIPHUm5JKBksrbu2BPfv9V8FJnGS2imThGVvHJdiiNB4EzqknnRq34uDWiZES09fD/xobhHRqE3JPwCP3exEjYk0CVUnd+/Py3atmPn0LYCksjaPRNxP2/DDhCNlGT2WUKJqiY5jpNATOCfnY+b3nDVQUN7uZaUif7YbnEdK9zeUbyBi8osvIMhslrxmY/aLnzoNpT9G373Qzjyo4Te4qXojpDCA8kVQbSYiKvvYa83x6ViM3S3cuWe7V1+ZFQ+ialsWXJrh7Jd8yOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by SJ2PR03MB7450.namprd03.prod.outlook.com (2603:10b6:a03:561::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 05:17:59 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 05:17:59 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
	linux-mtd@lists.infradead.org (open list:CADENCE NAND DRIVER),
	Dinh Nguyen <dinguyen@kernel.org>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
	Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
Subject: [PATCH v2 2/3] dt-bindings: dma: snps,dw-axi-dmac: Add iommu property
Date: Mon, 13 Oct 2025 13:17:37 +0800
Message-Id: <036132184140f8378f96be1b3989f834032e9d28.1760331941.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1760331941.git.khairul.anuar.romli@altera.com>
References: <cover.1760331941.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::38) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|SJ2PR03MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: 715d504b-c7fc-4866-6034-08de0a17dfa7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sNCa1g09Lj2sM5EXj1RGWQAlox2LzsxSwzYR7O+7Vyp7VQpCUr89uOZDP3af?=
 =?us-ascii?Q?E5PtKXNKC9+gm/q334XXIXDIWGQF/VOy2OxlJoQNPuxnm73BJ9V3pe+7QdbH?=
 =?us-ascii?Q?l1dH1p7D2cV5Rzho/jRGioLl5jxKh9YoMe+v7hGMwhF8vKsdj/02l/25WaKF?=
 =?us-ascii?Q?SjgOj7i5OSr/opWrV3HKyB8FZhO6YOyyKUTOx6E33HM8wD/40m75CRoogj6S?=
 =?us-ascii?Q?tv+xN/2XafUtrRkxfm2CL3ZzlgbAc+SkYYczI1QhyMKOp0YOMZ45F4gBvBXf?=
 =?us-ascii?Q?BmJE5CMEeMDH9QU2ePCmE62U/ONbEjmcYDWWaBgprmyw7JnQ/6RaBTY3lPnW?=
 =?us-ascii?Q?53ohVbqJdvhMHFgKnXM9KqOye0PsnhJIpRIePpjuyDZkSTVI8LDDDb3WcP3p?=
 =?us-ascii?Q?cX8IwuT+oEF56iAvUt/Tmc7C5yk2z0Rs/NwbHrHJYFuSvAco0Iaj9oCeCORg?=
 =?us-ascii?Q?D2xfsTaejJq7puC6aS/QfxE1PfujmqZXYHTpy5dHvh3GsKMf2RMkiGp4dsY/?=
 =?us-ascii?Q?KR4/CmYIu/GGt0DnT0c5/mCwoi7/tHgztYWiCjw9Feifhz1lAIhbtQI05U6z?=
 =?us-ascii?Q?7AcGjCzLdRUVR6Kh9Ux8xwkGhUmzf/dT7b7NGv3ulEIgXKLxwdk+lWBWlh6w?=
 =?us-ascii?Q?9APIr2QhWr2UQOK1jR750I2dVcgpOn1QRurH/xGxljdNNl8a2j0cQhsRhAwS?=
 =?us-ascii?Q?Dgo+E15EuzCj+GYwWXFsEK4xjZ0GmkT64PYRPnVWYLBBMFCOMNauqYik66yg?=
 =?us-ascii?Q?z+0K+AkL1ogp3EkM6/ZQVmyYPBxwfHZmdyxa8WyLaRG8n1QbR97oXwOoCmhM?=
 =?us-ascii?Q?9MlidVwuTfSgJoupQbMVm+61La3ux8wFicGuGBe5B0BjJ+/BFGfxQ/kIQx3S?=
 =?us-ascii?Q?ACy4p77Omby4tSis2RFiSUztZF+rZ5NCUsVCdqZkTDGAwiBX1ox+JG3Jn2dy?=
 =?us-ascii?Q?4Yo6bbF/rbPvcgN9l7cVdEZSA7FfFnz4+d7w6FzVjXVzM5hxxZuC4rzn2IQ+?=
 =?us-ascii?Q?NoAPBfXwryQGaZe2eYPIKoEKb8Np7EpV2S8wZyF6MfAh28lSGtAXrLOEsumJ?=
 =?us-ascii?Q?iLi4jbu6P/6Bb71c06FgDBY4QtKhKSrQqfKNl4rI1c91ARcwsYzeTeg4yI8V?=
 =?us-ascii?Q?F8cxX7QwNxpt0vK1tqSsDOSkBpYEiA+WmkbY48gm8UdLYswa+74fG6NXw/GN?=
 =?us-ascii?Q?FrknluMluMPb/dWU+Ud/lvL7524cgxaCaOKPlD60DRK3tRww1R9c27XpW+p5?=
 =?us-ascii?Q?Bvyx/SSllw00kN7Xl7dNGYbXmqeoUzWUDnYie8OgdVOdW+lgcLNmyxBfC2Rf?=
 =?us-ascii?Q?l/6mv+lIkF7eaECtxCyO3g8Ea4bXbjqjE2bvQwE0/Sy01NiMaJsBpF1GyAj9?=
 =?us-ascii?Q?x0YvEaTHipDepm2Bc0K+BsBPjgROVKEWWNcNJd0MLVKbEHAx5xe3ulabSe0o?=
 =?us-ascii?Q?g/iiPCuL3aJ8TT0zl08pY1dZzfJ8vJDR+GicbwuTuFxEZe06tq94aJt4Ipyn?=
 =?us-ascii?Q?BNxc1D3/ZfAsxFM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?//QCIS0EBDFX2G/+J6K+3+yUPA3XRISogAjETHyg39UehOTTlQxsKJalv3x4?=
 =?us-ascii?Q?5Su5dVVTiNpUh+CpF/dKn7LhhrFz47h1xhmSoEDfUs4b+JGh9+3drXF1w3is?=
 =?us-ascii?Q?f+AUxLFBmFIEOSESchXQ0q4Qvzg/ubi0eLgBWdq0sdgfBf4yl2LWNzBIcgYI?=
 =?us-ascii?Q?ZXWXpokay4YXQVVrNIo7lmcXbT9e85wuLo3LV0WkWTaHuNS1NYmYtVrrn0Ud?=
 =?us-ascii?Q?jqIJ42hwXGPG25dE3BQ5NwEO7u+bPFRi7FNXgkbKCZOhyQhawr3OHmdhLKN/?=
 =?us-ascii?Q?8jLatDUqGUhmafsIEprzlM67tykMnD+UclY0YyFzuKTponhT8dfYa/BPKj3L?=
 =?us-ascii?Q?4uL9Thsa1j5sQYECi6B7CkyD6vtaKZIlMlO/f3pOrY+tCOAFuwcjVKi6xxWQ?=
 =?us-ascii?Q?j7xr+XEdEENUwkkvNAlsWq42MAZGkfUSRIxCaw9UmAL/IfYUTxy3srzRat/m?=
 =?us-ascii?Q?yGbNheRmol/AR+eD62YJVSSv19hdKBz0xVzfym+eQ+tF9DJQeAz6lrhDn0IO?=
 =?us-ascii?Q?+wLPSfgstBe7x7Z3pTtkJQ3IVFEk1TtpQZDQI1GtFqVL8/RFO9d4jgvGQAM7?=
 =?us-ascii?Q?3Y5M0fXyuUii2+/SMGnXfuQRwCWqKdzFM1Z8IBrnCPzucIxjycBpRKm7SADO?=
 =?us-ascii?Q?NqRWAuYrRkvxh6ftR4SNz3iWDYqsXAIY0k7+A3KffcOUmXQxah9kpWHM5zb4?=
 =?us-ascii?Q?p6eJk7zW4WETAH8WlLlVAQFvOL8/U0+Oz/hhsevKVdIJ2PfeFF6xoEqo34T6?=
 =?us-ascii?Q?5kO4Tk+cq2gDw7bgH9LZ+aPjaCF3F2lokibZO0rVS8XTrCWwrQR2AiHhFP0s?=
 =?us-ascii?Q?T4NeIoMWtK3W+y0eELl+ya5GoTN/HwLkLNtp9FFb0MmWfSXzpqYSaLKbZ4Hz?=
 =?us-ascii?Q?UPumpvAZBqd3ndZo06JlP3CyhU+lu72RIgmf16JTp8sVdYuAUJKPfArTXKDi?=
 =?us-ascii?Q?jHtIql+5dYZ8TKZPsr0/DENCZgGaQD/nBVwxApITat04EtPkJavxK/Y9V5md?=
 =?us-ascii?Q?Ts6xsaOVCwz3noqBG/oVAToMVN2AqH1DjX95+hLYk4GlzbE5zeC5yPEIHJaq?=
 =?us-ascii?Q?NbjIgFdJ2NmRlor7/BkhKIlXkxMm0emfJNB3urNFTKvw58KLz90gWpV9Xwh/?=
 =?us-ascii?Q?brXqYkM3StXylTiNbNh1YkzAaCkC46uZUk7lLLfRfPrA/QDB2jRIvRlNaOc4?=
 =?us-ascii?Q?Lr39Kr32B0U95u0LIUezUmw1FwQ/pSc+x9LAZZ8zuuPGGYmeP/PJN2PGAAZn?=
 =?us-ascii?Q?Y4xb73mQLyoXh8PIVtX+GUxAbZthyAaiBy5iFZ4yUssPQwd9ClGtoKLrplde?=
 =?us-ascii?Q?GwOv3Y6k7EUkjrG0C0zo+79qK92LOb1fKTfWUWiH0hTqYMwQe8P9dkswMU71?=
 =?us-ascii?Q?aPEQo3s5lW0ll2+dCLSpAHm5Tgmlzb3yC5m66css2BpnvJfZ2iaz/8q3whHv?=
 =?us-ascii?Q?ftDWrExM/RwCcEV0FEMMelL4jY8DzyAhG8vR2cHG6GFte+cSf6hZ8suomvYP?=
 =?us-ascii?Q?oy+kcnL1zuiZeAiHDOrXQLhzQ6n8aJX4Jti4D5iM/RNJa2nF5C7Lr5bFs9eg?=
 =?us-ascii?Q?h3PoGPIiDj7X7ukKvFN/a74l1Ti/pvDIxKCTObe4UrHRIRXBWavTnmMRK5Q9?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 715d504b-c7fc-4866-6034-08de0a17dfa7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 05:17:59.5657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0blxUvhdFUi8Y/vPhzBO5J49DpnDjrVJG4x/P1w5efQINGws+n/qL1sTcU8QqfnTH1CyvbPOqchyMlN+1ku5KESf/NfsHxZeKh7/KVbPXno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7450

Agilex5 uses the snps,axi-dma-1.01a that is enumerated in snps,dw-axi-dmac for the dma-controller node.
To support IOMMU functionality, an iommus property needs to be added to the snps,dw-axi-dmac.yaml binding file.
This ensures the device tree binding correctly describes the IOMMU association for the DMA controller.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
Changes in v2:
        - Updated the commit message to clarify the need for the changes and the hardware used o
f this changes.
---
 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
index 935735a59afd..a393a33c8908 100644
--- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
@@ -42,6 +42,9 @@ properties:
     minItems: 1
     maxItems: 8
 
+  iommus:
+    maxItems: 1
+
   clocks:
     items:
       - description: Bus Clock
-- 
2.35.3



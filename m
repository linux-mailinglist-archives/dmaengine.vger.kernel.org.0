Return-Path: <dmaengine+bounces-9109-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPbVDUptn2mZbwQAu9opvQ
	(envelope-from <dmaengine+bounces-9109-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 22:44:42 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8524419DF76
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 22:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAD5B30E8C8A
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 21:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC89318B86;
	Wed, 25 Feb 2026 21:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BY/x9qcQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013037.outbound.protection.outlook.com [52.101.72.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB133176F8;
	Wed, 25 Feb 2026 21:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772055733; cv=fail; b=bdwnpBt5r+4JkYxfjcDwEdXSGuQ0RRZ5kDr2XsfiH+gs/ty+RKETcEgplPLCf71K/lXV0k5f4caMi1BbgckPVw7T/c8s3uE4WFvWPza5FwoiDbawNAEMgS5R52lH8sug8/cs6+m5tkKqIFnHmnW0ybx5IRMxrnttKW3Yw4jlUHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772055733; c=relaxed/simple;
	bh=puq4E3Exzl3yRwSLBk1eqXUeAZa6cL9Cq+frciH0ccc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=XCDhLpXvt7TNaAivkphsIWgRdPO0SCc4XO8T5ItmiTI5NOIGra/XBTAcHM1pITyDM1pB1nPLKLW3YG26cQ/GswmHTd9EScg3LJQ0VjU0dB2h6ikFlMglG9qMTJeiLzo6VJCnW/b+BkByP8QLIkmhGvqhdfbtX+gZbnf2TSEgXnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BY/x9qcQ; arc=fail smtp.client-ip=52.101.72.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFlKcIA2Bd+AMouiaJRt1cZt9S0zogPjVtCRqSpWwAroD1t8CxCWMUjREXHFGstE41lFj7z6EDttUKekezToQ3nrkZp5uoEKjSG4aDB6edd6RKe0t8R3JYZ9WcaOxSJNyXwnWIDEjEYlv43iJv65m8vUf5+qELpKxWM4xaRPyx/Y7O4LIAnzQAP5vO7QYSKsbColEda6LZFqOt7q2GO1sDzbaKTDVdrSMOfIe6Qb9muukxhDJnnJT0qx0T77yepdPJUJbMVDqA2h5LGJcQb51t2/nBAsdLjZ0+tPQnKu+F6o02Ljk0/KCplRtTfXvkMKwx36S5PA92bCPdiFmjQzTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7iXAxODJn2Ylhe2KGhHMuhQaeOeX6X3UG+c6ISfLHR8=;
 b=mmLVVa71hMj4qFIp9JWAK9XRg09XkS9wslZIDNM3aROuzfA4tjVVmIjODasKL/QQql/LwTNGXKNXcvYO1deZWCnsgAZpdBvuPq4uns9DcQAOkvcRwGif+Bmt/OLmbQInPAs+g19PFn29WlbV/qLAFia3d0vckWOIUVEpsxPxw3t2kPxLospeZNXeMzuqXXA/s83AkSTLN/xDXQAtN9Z5SG3elUtYG3MEDuT0P8KZUOtjTWlA3Dq/8SagI6DjD6gl1a6325bz0gIRtkO5hhyR6OXE1eWBE9uWwih2cHRC/z8rvdcoZqURqVc6ia6xs0ARs6qurc7phOYLYvfUJ20H2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iXAxODJn2Ylhe2KGhHMuhQaeOeX6X3UG+c6ISfLHR8=;
 b=BY/x9qcQ4EqHhoZIEp2yj5C3PE4LQLlEU5Qd4aPWZkZD7jbAuwY4JEXxZn36GQTu3nTSqMlTzENqQrndr5OUANpKtuwiRFsAayGRBT8Gir9HIIZ5GCHwnYt0kuMyI8Z8Q++Tdfm187/Ns1sHqqGwsB5HFeqKMfbhAJBYpbB42HbrROlpisZmJLCTNiHuhCaeS0Ju0r+S85jddAmcSATCfcEgoUnndlA9ZwiLE5XF+4ajf94Xz7E/9OavpuMFl58IjTTunZ7A13aKGz18rZD0rtVZ6HT5hu08BGHTvml4AmtxPuLOv7934Grb5B88Y6z9WgVBFqAcH6lmc1nJD3NJ4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM8PR04MB7346.eurprd04.prod.outlook.com (2603:10a6:20b:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 21:42:09 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 21:42:08 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 25 Feb 2026 16:41:41 -0500
Subject: [PATCH v3 05/13] dmaengine: mxs-dma: Use managed API
 devm_of_dma_controller_register()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-mxsdma-module-v3-5-8f798b13baa6@nxp.com>
References: <20260225-mxsdma-module-v3-0-8f798b13baa6@nxp.com>
In-Reply-To: <20260225-mxsdma-module-v3-0-8f798b13baa6@nxp.com>
To: Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Saravana Kannan <saravanak@kernel.org>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@freescale.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772055708; l=833;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=puq4E3Exzl3yRwSLBk1eqXUeAZa6cL9Cq+frciH0ccc=;
 b=yEFePjx+QNuCtXfBrELXx1CIZ2jS0usJjaqC5qWA5Qngijbm16suCxfDEXHDsUwmr0lOzCU/D
 ZzLpdm+SQXLAyswmIC4ZggmvNAls1sgfLznm0LD6JrdFVDcX/9D5kli
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH0PR07CA0052.namprd07.prod.outlook.com
 (2603:10b6:510:e::27) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM8PR04MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: 55594dab-abf4-475d-f966-08de74b6b9ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	HgmpvuQYRTED4ooP7WSz6RvhZLO5JjMCHqcHTehMLJPYaE1ahg1pPiZWokN/NkJWOeiwiVITOD/z409pcWGS0+V54cgDaR+3PjzG/Kpg38g2SC1kVI8vF4P9viBzmRblxbpBWAYNVX0z7Cl8F7uhHaQdVtQIM22Ml2Iescc2wLOQ/QdOiQlVaz9eFwnUGrT51rDV4xyOT1xFt8bCVshhI27tIG9251ehQNi61x4FiqlZuCp2EEjFl9Z6l4TVF8V3r3KhGpKWHUrSmNyCurHX18XvyMbiZNnNa02OOwjbhVBR4Lrd/VltboQnrIP/YHG3tZBLO2nipfVqcPCFQgFtsEMnLbB+cN3/GwptvaxjUg55LSKkHuP8HEpAw/QAGCELqwD0GBM3Vq+D5J7jblbYCGmdsJFyZNupQ4u/dvRmgo9yilcCXIYjopFvvc0xQfdLQMZf0yDRQgP4usHFz/y+/r1QWW1LDFmE9fE3Gav64NkZ8DKv+g/dWSZqjFB4NSQXmLwM9/j0haB6QNHy5p5Fl1AAQz1j3XSCVIo5ZLIEoNVjpiOcUNS4o1FxbzYuMb7e3e7xkF7hq2DJBdUlkdZTZKxs08XUi4OKOwXAFXy3gLB7FQ5ct0iOI4xrttNLwBugRm5oTmd6Hwk20UlUia/nbgwbBvm9nzArkLkMy/HLl/YW5TbUBwA/jEf8bmp14AYLMWARHTvAq7cf4RkZXN4wWvFaj7Mh3iCb1WuLYOLVRGGJqCxOnfz4TbGLw7TDsYWdfrbYtePcaWALfS83WsolAiZQVEn57VHT0kJFE0tYlp4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WW4vR1hkTDZCb09RZDlJQ01QMnZIOTlXSFhzTVZjc0R0aW54OHJjbDk5ZXg2?=
 =?utf-8?B?aVBQTDFObDg3SEFDSnRlWTFQNHNFSHAwWWIvVmVCYU0wbnBtaWZ4Ty9NZWZp?=
 =?utf-8?B?YXlKQkxKSmRIQTZFemVRdUJKQXM4ZTM0dERBNFoxOFkwRDMwdU1ueUdKYTVj?=
 =?utf-8?B?bDRaTmtjMHo5dmVNcFNkSkhLRExiK01LUDd6N3I0YW90QkhFaUhUMW9IUEI4?=
 =?utf-8?B?Z2p1MngzdnRyUy9NazJnNEwvaGMxdjdmL1pIeENNdW16QzV6ZCtaRDF6bTha?=
 =?utf-8?B?RTh5WkZaOTR2MklIcko2THNKblNuTm1EbVYwM0hGY2JxUTRuSm9SUHQwU3VX?=
 =?utf-8?B?d0JvdkxPcVhHbTYwdDRhUENUMkxnR3dQWldaVDc2anZxa1laQW03dldUS3Bi?=
 =?utf-8?B?WmprdW9JM2JsMERtMEdLNnBNR2dna0RkSjNFenoraXEvcmhLQkp4a1BaVUxK?=
 =?utf-8?B?c20xbTIyT2JRcDlOWTVsOTRVVkpBcGEvNXN3c0EwOWVDcmR1Q1ZzVkNhVE15?=
 =?utf-8?B?Y3VLNE5HTXVxOHpJS0ZhejJubS9ZZnA4VlpQV3J6bEdiQnZhRzlHYkR1SGNl?=
 =?utf-8?B?TWcwR3drWXJOc2N1S051VXd5OEYyYmNtb1ZjTUI4eU9Da3pURnMramRXa2N6?=
 =?utf-8?B?UmdIQVpRMnhZN0cxYi9QaXBvaEdXNU1WUUlOYW13QnBFaEpmZkQ3ZmMwVTJ1?=
 =?utf-8?B?MVMwVUlnK1ZQTGt3MnpIeDJna1hmUkF0cUM4VmhHVWtHbitnNGRSazZrWEpB?=
 =?utf-8?B?Nk5kT1NoT2tYK1lWWVROSmxVUnVPUDNIRmVCckxCaC9GS1JLcFZSNkdacFNS?=
 =?utf-8?B?bXExZERDV0hNWjd6Z1RURkRKekNuREp4U25jTG1JYVBrSWlESFFCLytyRm4x?=
 =?utf-8?B?VmhJMFFsTk1JZHVQejRkcGszUHMzQTVaMndOWDBVRzF5S3FURzBXTHV1cDRv?=
 =?utf-8?B?T0FRSEUraWQyRnA3N25nZ1cwSEUrR2pmUy9YQmVYY2tJS3FVNnZJZGNLQ1lt?=
 =?utf-8?B?ektvMEtHeGl6am5JQUdKZnBtSnlvaU9ic3Eyd050QXRTWmIyRkNROEhWSUNm?=
 =?utf-8?B?U1JORkxIeVhFSTR4NDQvblBGa2FOTmg4SFFneWszMUkrZVF3WXRTZmZFdlpq?=
 =?utf-8?B?aGUxUE1HWHdyOFpJUzZGalh5R0dNWkx0cUg5dDdQSFYrVHR3U1F0TGd3SnFw?=
 =?utf-8?B?V2NDZ08yQWpyYWw0ME9Mczh4MXhDNk9ZNEpKSlFjYlRzclphamNKR1dTMjhZ?=
 =?utf-8?B?d3duVXJEdUNQR2tTK01zalhyK3NVSVRleDVLQVZaY1cxTUJMK3RIWW5mL3Fo?=
 =?utf-8?B?VnFEM2xOSVZUWUZSNitBczV0U1lkbllDbHZjZEE5eTNWQnJHVm9BY3hrK3hw?=
 =?utf-8?B?czhNVU5yVURYZngzMFFvTzdLQUo2c0I4K040RUZoN3hzV0hmTnoxVFlyTWNr?=
 =?utf-8?B?bHZvT2toS2Z0b0Q0cWw4bGNvcm1QRDdCMFpyMDBDK0NCWVJBN2t1UDdFNDNr?=
 =?utf-8?B?bjhnVk43MERTY1Urc3VMVzN2c0R5dXFTSnJoa1R1d1JZRXUvK082M0xqdkc0?=
 =?utf-8?B?dHNJYlQvZThPazNuc3NSRTdseGk1Ukx4WERLaHZnenF3Uk1MZEMwbml3dXBU?=
 =?utf-8?B?OEVXK1BXdGZqcHBCcHczYkxHYVEydUtQVnoxK2lvSWVEQ0MzMWNLTkI5STVH?=
 =?utf-8?B?ekZ6Q0x3OHRrOGNLRklKbFdPSnNLKzVGRmNYVDRTU2I1ZkdZOGR1SVlqVFVk?=
 =?utf-8?B?NThFNGNKWTJzTjZmNDlvWDBTZ3lxNzBmRVJab1BOWkFjS3pQZ25NU1hiMmhD?=
 =?utf-8?B?YllWR3RobVZJNkxhWHkwa1ZuRUNBUFpHWVRhdzVwY2k3SlpiZTNqcnJYOGxq?=
 =?utf-8?B?L2tXVnJwVWhDK0h1U3diNzV2d1J0Y0FLdkNOaTVNcWVHV1Q1M3AwOXM5Tzh5?=
 =?utf-8?B?ZXZhVFU2STdIamRmSXN3cmJJNU93a2JzSmtFdjVEMlIwdUdTWm1XdTlSLzVU?=
 =?utf-8?B?SWIwMGptSlRCdkZNd2FxZlNlK0FTdnBnU0NxbGxLdWRVSmVTMU43L2JKU0hu?=
 =?utf-8?B?a0JPdjlqd2V5NTJ2STYzWlFLRHpOYnJIbXI0dm84OVZ6K1hZT0hvUkNPS2Zj?=
 =?utf-8?B?ZmxiZXkzekpFTmdCQ1RQa1FUN0xQZmxVaFNPL0VoUE1wK204bWhpaHpvZ0lv?=
 =?utf-8?B?T01GZ1Naa3hXalBwSk1aNFkySnVOUTgzbnJsSlRyVkEzbWFQWmxsbzA1bmwy?=
 =?utf-8?B?dmxmM1FtVDcwaXd1cDdZQ09Odzc2MGVpZDZuOWpmTmZKSlU2WnRaWmJCQ2Yz?=
 =?utf-8?B?c0NCdS9IV2ZKanErcGMvQnJiTnFOcDhic0sybWpRWGFQQVRKOWtYdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55594dab-abf4-475d-f966-08de74b6b9ee
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 21:42:08.7607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4CRYDt9n5/6QEInn9zzr4QN6fSmNzR9tAPuWb5cwIJacpKo7fXFOw5CsiuN1SCK3bkzXkfRCy4Nr/lxsZV9z+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7346
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-9109-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,pengutronix.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:mid,nxp.com:dkim,nxp.com:email]
X-Rspamd-Queue-Id: 8524419DF76
X-Rspamd-Action: no action

Use managed API devm_of_dma_controller_register() to prepare support module
remove.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/mxs-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index e05bca738d2efe45d385dfb2180dd1c75b00163e..be35affb91576f43d4ec41179f4f0013eee2d347 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -817,7 +817,7 @@ static int mxs_dma_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "unable to register\n");
 
-	ret = of_dma_controller_register(np, mxs_dma_xlate, mxs_dma);
+	ret = devm_of_dma_controller_register(dev, np, mxs_dma_xlate, mxs_dma);
 	if (ret)
 		return dev_err_probe(dev, ret,
 				     "failed to register controller\n");

-- 
2.43.0



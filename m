Return-Path: <dmaengine+bounces-7772-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D638CC87FD
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 16:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 254D330A3E48
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 15:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B808635CBA8;
	Wed, 17 Dec 2025 15:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="N+zdelqE"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010013.outbound.protection.outlook.com [52.101.229.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86CC334C3C;
	Wed, 17 Dec 2025 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765984664; cv=fail; b=nBSyTUpDT5mqfLrrnoTSbTpvN1lKbGBluluhNcA5wwx8TNrbMRRSN06ajhxz5f+wiOet3qiKyl1Pg94SjwLtednkge2RyEgP/HKoI6SVFFXNmYPTNVZUqW5+0BxicTQOcflTSAWDO+XNw7fGgbHVK1rlmg6/2aEOeBuAAb07B+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765984664; c=relaxed/simple;
	bh=DAEix9MDDCfrjOvRnRB1FL/9rVvY1942DyeRzPRmYBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I8OGy33uhOzlnrLalzK3hY6ogGIUruCFIxxCtdnOiDRBxwRcmKubuv3R6Wjak6SJ11tysdIkbKwtU1G9SmZ33myMQ4+O1dsUEuYBoDmNnTwuReboksw2ciJ4Z18j9omBTaGQsi/vFbn8KQFYgWaGMMv/uztPb3G0zahnQZ8eQAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=N+zdelqE; arc=fail smtp.client-ip=52.101.229.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFA8Qoq4MoVhq6TMAptODA575I6ZuDweE8fgMheaJI7Fg0RJA8y9GJNBozErPy9t+9PcXG6QnpoS6eAn096P4XnJqQJh3DZjzHhpHV2PBvibSrSHOVCx/VPGZZKXbUSEG0viJVAuFYelaWfsWui+EOirLZclboOA4DenNGMN0Nrv8aiteEVku+y9R3ye/fu9VWPOb4V47xinmj4RjVd0oGKrYBCLiK4B12WRuT2MtFv4RNiXGGSntbf6MNgidKyXWBYfoQYQqn4bgwcxcRrHG+leJZcMCryw2sKe3LQT/hsnf/mervWs8mqCR+EAuLNpnnpkj8rhrOJeIkNRm3Eexw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUoju2dkZjW3upEzmalpCmz+unTj6bHhTmBwkFo8YzA=;
 b=uyc3lReUBh7jCcxj9ATJ49/W6/LlStbHiiY6UUxnn9uj61Mc7YZH5zVqvi0dwhwXjoe2M+OalTNk+7bIV0jV0ZBpR4aK+lRd2VJaik5iMAksqS8dcrbhFtMcltRrTg2K7QBgNq2Q/m6wRuUbfholja3mishmxn5uiDRp4FNOdBG/4ROzicWQrB4cEnDoz4gBDTyjTwdSc2xFKUOj1JawWQ07xC1ZGMK/70/HTD93QBIwTUFea/XG0yq0N2H0FhZ/hlBELbnIwg0zFhQOEKfj9UB404nWMBe5rI8cfDTj0hkZXgytQTUjPYWzQlq3EW8dk4bKCb2Eu4ifv9SdSw4VHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUoju2dkZjW3upEzmalpCmz+unTj6bHhTmBwkFo8YzA=;
 b=N+zdelqE+JKLFLiuHZf1w/h5tLSMIor8v4hT6oEq84elJvR9Wlpt2Koldqbj2V9oQFhck+oGP1GWLPYlLuab2bTzG9ML5CeRN/fG0s7ed63PsVRikzTjJl3cK1eOXzrIvF5CtpQ7GCF37ooN6q4AH5MoAXH1Qo8WX5BNatnIVTg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYCP286MB2863.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:306::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:16:33 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:16:33 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com,
	dave.jiang@intel.com,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	jdmason@kudzu.us,
	allenbh@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com,
	logang@deltatee.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	utkarsh02t@gmail.com,
	jbrunet@baylibre.com,
	dlemoal@kernel.org,
	arnd@arndb.de,
	elfring@users.sourceforge.net,
	den@valinux.co.jp
Subject: [RFC PATCH v3 22/35] dmaengine: dw-edma: Serialize RMW on shared interrupt registers
Date: Thu, 18 Dec 2025 00:15:56 +0900
Message-ID: <20251217151609.3162665-23-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251217151609.3162665-1-den@valinux.co.jp>
References: <20251217151609.3162665-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0037.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::12) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYCP286MB2863:EE_
X-MS-Office365-Filtering-Correlation-Id: 34da8626-ba19-4028-b25d-08de3d7f4345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e5d9zYJNxSwOV4HTW+sbHhYyyFUtFbcK6c+7O0VbPOVkfyoa4/Npcm+hru9u?=
 =?us-ascii?Q?yznfxqm5iPzPQQ2/O7B6JEKCnIH3rmwC8evZq16bzjc4BB/4CgvSZyGaUGrM?=
 =?us-ascii?Q?JhZmrDDwo6be6PW43VCWEqqWSB8wRFx4LWYaD6B1KPLyaqhTxsy4lNm/3bh9?=
 =?us-ascii?Q?nRuGsu/0LRto9zhUYkZSnKP9BrfFC+XAHA7esYqF9xAekAK/sZafBUpcW5bX?=
 =?us-ascii?Q?T6SlBdCuNtg+pKPtxhrY+kJkDMrwGKGbVnbWzlVziyd6Oy0VlcowUTQNTMG5?=
 =?us-ascii?Q?K7/mmbOKvt1VV9iKWUcp0X1YpXllXT/tv9wqlPipgAAJv27dgbZ7BFhASZXB?=
 =?us-ascii?Q?Mm4XTlhIKRNXtX7gb3xJxqPEu6m33t718yJ/CiyENySkY5Wh4ji1V5MxY5ei?=
 =?us-ascii?Q?LRTwZnkevNX6w2nKO0L5S4CFFp8lvCa/YugVpLeo03a0Svyeq8rwed0+zGMv?=
 =?us-ascii?Q?TyRhdA7XJiEM6eC86oJa6lE3TQJI/h8Ussd6NoDmFuLeWCWnWJB2TMwmX8RV?=
 =?us-ascii?Q?OWQaGm6qXHpmy0s3OkPTPYQm8KcrCRsFeDUBL8AaWQPoVKG+t288ppJuyWgs?=
 =?us-ascii?Q?ULeQ4o4DaJfpdDA1SnxKgqaFGDuQ8ae+XNgeE8IGZxqZzqx8Zc48DQU9Yn1Z?=
 =?us-ascii?Q?poFaPnj8i5FuTNfHp0CAWveBpSlOn3j8FnUKVfexYG+axxUMoaqQbXEkiegz?=
 =?us-ascii?Q?pGsXK110ZqgCS+gKlMqnxuTx2hYpoQ7X4qddL1FUidKm4cHbZGvG2b/sVDe5?=
 =?us-ascii?Q?89KN2phDFhKtRPCdld/e2MrdirkHKQPcbK1upaIzjfA7xQkte52+MMP0KwhR?=
 =?us-ascii?Q?R0TkwwTAhznfChIFlUXu+fDto27SN7wzcOb1cBPg2tphDA+Xc4/2HCmge/mC?=
 =?us-ascii?Q?vpAwvaD+3UQyquRb/ffvAHnBhQl10eFLJeKsISMMqi0lzWpRT2rkQ3Pzq0Zl?=
 =?us-ascii?Q?GlpmvoRgd8uyLczgpM078JM4Lz+SINHyhqzzLwlCtSv6bLcvmNU84HtDVlit?=
 =?us-ascii?Q?F7uR6nxIzqBmO5+dpTmJQs5ruDGRz1IGk0SURiqZ8GTCu/oslD3CNn0feQB9?=
 =?us-ascii?Q?Bsublw/7mIgFFv10SDnm3aq7RezFy5ZymJvQRGbes8pJt+RMuhAAbaGUKmU3?=
 =?us-ascii?Q?ryjcbrmQZC57IVzj5GP/Q1Yz0A+bydpaD0fBoc2Pmupj8BFdzS4Jr6pdZqAf?=
 =?us-ascii?Q?qoioFFmqxubH6qMz+AuOY1etFFn9CHVAqjChtdz5RmaJc3pr+iPKtPum1MLF?=
 =?us-ascii?Q?ZrLBN7w4u7fdgVFpzulWNI7JZx8XamTQB2OZBQEJkVSffg5/I3+RSZCnMwnr?=
 =?us-ascii?Q?KQvQHr2Ev9NBZoV6fWUrwzis/cDVAqrflGLFxMC0VXyeQ8EXHNjvVecOy5kx?=
 =?us-ascii?Q?RVSQaCATrnc7ZzpTY+1H/vvPhzKYqt5PTl0JT3QfapPS6Fj8GgY94LBw5SSc?=
 =?us-ascii?Q?7vjpjKgAfccX8YxOePwA1TMpDyz/jaJe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Afkc8KjcGqfGzqWjMgS84LMztR7w4NpxBek0a8TcNUyKTfwLhDD7SXh6mwVJ?=
 =?us-ascii?Q?Al5YdKB5qHknsBinhvAgE0D+U9r36g5hLj0ggHSLI09V09D1cx1MtuFUutcr?=
 =?us-ascii?Q?44CkGTHOI5UhtotHhOfxlakLR1VLNSoyGSnotPa3IRU5uC/aBTturJxPyNYm?=
 =?us-ascii?Q?vvAJPCU4K/CBXlhFxtsMiGQHQZAgzB2JlDOaPkrU4WTLksdLJ+M6K9b0OxZq?=
 =?us-ascii?Q?sYsxjpPtCPi9dH1by6G+az4ZYqkgNG8h9EjraRT1gXKpJ8q4ROk6tynmU/DV?=
 =?us-ascii?Q?MptPDlM4xXJw7zpAODyGNwKooD6Y6N9B+iunjQWS2ietBDTbJ8jWIeTFYDA4?=
 =?us-ascii?Q?sTKYEvV68VA40HqMCISB3P+2Vr0nLYyvQm23EKXMrdeJ1yR1o6VDGhWzchrO?=
 =?us-ascii?Q?MCbcA/WU3Q/6NNaNNtKi3V3ZEAqeDPZzB2zSRTfl2D3TtMMuDhs9aFYoB/m5?=
 =?us-ascii?Q?BI46HCJcrmhE+I7tnnaf1O5eJiea5cBoWS/d6MCIDbDIzPsZsok3/XQoIIz4?=
 =?us-ascii?Q?yMSbkwjK8E56UXL0ZoroOKxkT1RNGwzK87BIR46SasMHuImKWYz2gZpylOFG?=
 =?us-ascii?Q?g8kexvwRbmtDLv6KVuA6oqf0tP9wUl1EkRGdYmcvrGzIXBYLqYYSjMxiJhOl?=
 =?us-ascii?Q?VxQtyBvD4VZQu5NkY+ActBK/ZLK47h3ROv1sJtMXjHSg9EsLYA2Mim2AlivK?=
 =?us-ascii?Q?JZvncHNGlcGfjBsTG/iqK0RoCbiOn97q0VWYtBmD57rRKV27BPXfw0Egfq+U?=
 =?us-ascii?Q?gxc7TGBCkNBTWSY5MNtd7iwOvtY1sjhNfXyE1SrczuWSmgREMs0va4HHLbuB?=
 =?us-ascii?Q?QxvvmWGlLzYnmhv/Df3OzYRGDxoh1ixD3bPSS3QJU/MBLXR37EJ1eoEhzJJc?=
 =?us-ascii?Q?z6MP49oBXGlpBk5RmzFBIr3h+4pEZwQjDC4kGsECDzp7VyrXnBTyH74Y/amO?=
 =?us-ascii?Q?hy5N9wBhlfFK/QZJKIS/a0zf2xThG1kl/VvQ0bXItMvOP/hF6Q33iKN7HWjw?=
 =?us-ascii?Q?gKK6gUFW3LJbOTEoTf9oNnr06uZiS77FskzAxaO5gPWmvwxlpHBi4FMNIRqQ?=
 =?us-ascii?Q?wIItubRCu6x7FEkUW2RDq3ewmyUkg5nW9UQvkg8epkv0LaaWNujqmDCYuHdm?=
 =?us-ascii?Q?UYikUFScqvlxIR/29hirtqvyNr6IvBhgzwYCtL9MUEilievCHJteU4Yfj2rM?=
 =?us-ascii?Q?hN1yXkak2tj6Bg5jiwjbSucgFjz36kP2NrSEsZovT2SnII6z5OW+22Jtkwpy?=
 =?us-ascii?Q?OqXwMshAtuS9XJI1SNdUptVUWF7AuK7TR+IMQAAO3k4hS1Hs59deoltq14mv?=
 =?us-ascii?Q?iGvEB/n4pMzGLczCd5QEqUdZqMBhCwB7ISVqH3h7gX3o4BBCv8+Uz6FP6brg?=
 =?us-ascii?Q?1hCi/hX/E1qitVnbrPptPV5iN40fVEBjuyvnlgBk1jVzFpAtPJt0MAyvqv5n?=
 =?us-ascii?Q?snV4NidADwi1wqsmjGVjRYSn2Su91uVkynMfPag34xPgm+RYNj2iAGbkEqE0?=
 =?us-ascii?Q?/HTha4YNmfyEL4Fw+4VEsZPS9BKzgfrFuSvgO9V+LU99++EUJMVneBdXAKXv?=
 =?us-ascii?Q?3Nd35DK9VyHeneqNq4wserG5uGWchoFK1gscNejhlwUB60vV5KN061Jf/e+Q?=
 =?us-ascii?Q?LEp5xp0Po/XyC2fkFLqqmSY=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 34da8626-ba19-4028-b25d-08de3d7f4345
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:16:33.2599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: laA8zGsySCfMmyY/45k+plZwxPHyywrdl9V7G1SkQI/d5XdeVUnzHMcP7EfmT0qGVlbNZov4XbUmwWdM3zUGBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2863

The per-direction int_mask and linked_list_err_en registers are shared
between all channels. Updating them requires a read-modify-write
sequence, which can lose concurrent updates when multiple channels are
started in parallel. This may leave interrupts masked and stall
transfers under high load.

Protect the RMW sequences with dw->lock.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.h    |  3 ++-
 drivers/dma/dw-edma/dw-edma-v0-core.c | 13 ++++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index f652d2e38843..d393976a8bfc 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -118,7 +118,8 @@ struct dw_edma {
 
 	struct dw_edma_chan		*chan;
 
-	raw_spinlock_t			lock;		/* Only for legacy */
+	/* For legacy + shared regs RMW among channels */
+	raw_spinlock_t			lock;
 
 	struct dw_edma_chip             *chip;
 
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 42a254eb9379..770b011ba3e4 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -369,7 +369,8 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma *dw = chan->dw;
-	u32 tmp;
+	unsigned long flags;
+	u32 tmp, orig;
 
 	dw_edma_v0_core_write_chunk(chunk);
 
@@ -413,7 +414,9 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 			}
 		}
 		/* Interrupt mask/unmask - done, abort */
+		raw_spin_lock_irqsave(&dw->lock, flags);
 		tmp = GET_RW_32(dw, chan->dir, int_mask);
+		orig = tmp;
 		if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE) {
 			tmp |= FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
 			tmp |= FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
@@ -421,11 +424,15 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 			tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
 			tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
 		}
-		SET_RW_32(dw, chan->dir, int_mask, tmp);
+		if (tmp != orig)
+			SET_RW_32(dw, chan->dir, int_mask, tmp);
 		/* Linked list error */
 		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
+		orig = tmp;
 		tmp |= FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
-		SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
+		if (tmp != orig)
+			SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
+		raw_spin_unlock_irqrestore(&dw->lock, flags);
 		/* Channel control */
 		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
 			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
-- 
2.51.0



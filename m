Return-Path: <dmaengine+bounces-7400-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B88C94292
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 17:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5A80534AD30
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 16:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FE2313285;
	Sat, 29 Nov 2025 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="hSWWwYV6"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010018.outbound.protection.outlook.com [52.101.229.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781CD3126CD;
	Sat, 29 Nov 2025 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764432280; cv=fail; b=bmxl879j47uoObA+Gl1Qz3byktZ8VvhKPBjx9mf8V35Rf9tSGg7lL2l5mTsx0U8jcyHSfQMvrKZJgQnACb7QR0AjEQ88yxyaeW1HdSl5XwnHbDw9BUWTdpKxWYwsY4BrDoCyqhyjlHVnaCmXIujNfniRmJi2OYfXYVcnCFNgDTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764432280; c=relaxed/simple;
	bh=W02uTkf0FXQ6LJTGYq4tPBnjbP5GqqLYQhJkdKN2jOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ucFC8VMSoBIe2NPLLdegeTI8NP8woNUekQZFbqvfIr5PnCfjhu/r7pvE/3E+AqEXoIziKuGstPYE5FVWy3VsCogUYer0UuUT5sJWJwcvlr5SKMEdxX4cJFngIYAytN8ahfydfrwv+pi3V3f5ej8HHRZ1fBKY0UfHViGbbiWRDLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=hSWWwYV6; arc=fail smtp.client-ip=52.101.229.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvpHPMaixKuGCyj5fWmp2kEDkBuXqiAbbp/XSNKIj8jc5r36Ne+Bcfwjtd3QBVyMDsF0S2UXC8pU++kefP6gsPVqr7ihbB4CCZc9LGDDt+sEvZKCmAc2+JmEVbOlM1Ndb2yY6X12AxtCQ9OylenLi7Y/9CDAohQWjk4ZLluZFynirdhU8sJ48GKOqbySV9nfh/7E8IHt7V8pAid6CPbq/FX8oqgvIRl/PgsIjdMrllpsStmf+mhInkRK7l5XZ6i8Hm+duXcZL4oEH7cgTTStjMFv46as0MHO1fqhQ9AAjUTTFhz6uMj+xxFT/HI/7xoPuZ3WVxL59hwPsa8cd8qirw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAsVYKCEsLMBvBTyIK/v4ou7RuXwZuDVdj8SkxRt7q4=;
 b=V1KooxMSe8aFlFFHeMgkhdMD4LryqVYah6QM/UfFoIs7NQvOxwj8/7F9Q8PCSTWHxtSWmuodyvHmG0k/WjPXfuxUt3UMgekbrNvL4MSMzdAUG1hXSvL6HaFuDFOiSdYo8nDGzljnscFqRlaXn2gRmwsB+2eO8ZV8Qft6O3I19FTg1um35r28LpS9WfC0djat5oL9HhMu4jxVCwhe9/hMdIBk3hgQgu2RtC7Lk7rk1BBiFqKYrqeyOHWyT/B+2RbFcGk5BhOnaeFAgsYKlV+vzPZFmLurgavBkycY3m13uaO/ujgaQNE04Z62BbDKUNJ5pgtlmaU92Tw4EwsnG65eEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAsVYKCEsLMBvBTyIK/v4ou7RuXwZuDVdj8SkxRt7q4=;
 b=hSWWwYV6BDcdpzyL1yocaXrjO+4p1CYSVeOEIMnzoGaMTKFjXvNsnT0AGQ9XcOry1YpYFa8EmuCCpY2u1/rh6/Mx5uSAZAXeJFe88TXnTvKZuvqZ1HzJ8BzYo15NyDIhw7m9e/3++VzK3sAZihCfA/svUkhTPVd+fEFn50RQPJ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB4684.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sat, 29 Nov
 2025 16:04:32 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Sat, 29 Nov 2025
 16:04:32 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frank.Li@nxp.com
Cc: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	vkoul@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com,
	logang@deltatee.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	robh@kernel.org,
	jbrunet@baylibre.com,
	fancer.lancer@gmail.com,
	arnd@arndb.de,
	pstanner@redhat.com,
	elfring@users.sourceforge.net
Subject: [RFC PATCH v2 14/27] NTB: ntb_transport: Move TX memory window setup into setup_qp_mw()
Date: Sun, 30 Nov 2025 01:03:52 +0900
Message-ID: <20251129160405.2568284-15-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251129160405.2568284-1-den@valinux.co.jp>
References: <20251129160405.2568284-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0217.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::18) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB4684:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f2384fe-1cea-47a0-5036-08de2f60fc09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iDtj7cutnMW0w8xJ2Jua/xafsikv5K9OV3MSahQaVD2jdRrFAENvDrboifab?=
 =?us-ascii?Q?Jvyjo0y5cPPi3yPUsoOXs+EqP9WysHaOztt6aiBiz2+PVEeeZHizIEVEMyO3?=
 =?us-ascii?Q?B+pFsIYUoijb0thZ6bCrJopeW79/mOubfAVJ/c0dBaM+r/+YLhxzEQD6iLnh?=
 =?us-ascii?Q?yKvu9dCKo/rq/hBCumdYhQXXp5xbW4iSVTRLvgYgGgY0g41tubBnV10J6roI?=
 =?us-ascii?Q?kAdVFjxjvQMEgiGv33Cxv6o6jGDVDDbKCCJPFQ440yUWZnwBE1+q9oZPxFF0?=
 =?us-ascii?Q?O2e0s5bLju6BxbQNq1UwfJ2tnNvERfALdxTRMQZYLLPAm2vtiVY7Seyx16/8?=
 =?us-ascii?Q?Me8RqmUzLHf/BC6r7sTmrbmrlzc1IGbhvUmnRTjRdGweVgGVvzlBylLM5v/a?=
 =?us-ascii?Q?hqGEIEwyKKM0X264kS0SOUG5gOEsVK+h0PZhGOrIHaVshhnjF9xu8uN2mBtv?=
 =?us-ascii?Q?AxjwasiYmxqJh7VpQJ9CSsxgdgJjph788J28IlY3U4H9BUxSnGtMnJS1D+FC?=
 =?us-ascii?Q?g8gaACaBBIm4zq7/MCih9TC+YVpEzzpjqNnb75AwBZgnQlIVc+GzVL3Y9yc2?=
 =?us-ascii?Q?R00cP4A3iPD2gDG4hDYXv8JHVWQ5QJZEXSVulSztf7xRrZhHT9AihFhPuzh4?=
 =?us-ascii?Q?JU6badgyJkmfIN7fnomMO+EDBgxjiun3iMdRtnfSaUtqSpZSqSEkLUAAsLmR?=
 =?us-ascii?Q?HOqatvxRT8gwpx41YHpBJ4m5yWqercuSgyNDhaMpOL3BRiTRVqgao1tp5hYk?=
 =?us-ascii?Q?5LRCK4AOz2jo9WqaqdzTIqAihiujHmTbsISUXP5BCgwQW1qrz67fI3de1im2?=
 =?us-ascii?Q?Hnq24BNRc2qJ+veDGl627yvL5rBklbx6G1vzHAXuwYZSEHL9UwRIz5aTCFJ/?=
 =?us-ascii?Q?P71zaz7oE8fVdZHuujNCY0HLFU17LLqibC0WhjDB1J83OUd7egKXezqnJck6?=
 =?us-ascii?Q?ppNdp8QFdOcPmi6HXuEe7zgRQllj6fTPiTV1ODqbQl/VGeTZh/DeqZ9bF6kq?=
 =?us-ascii?Q?xxHMVAhtarpvCvKxqo7Pdr87XJe3NFLNUr04pW0a6XW3QOmQjJZpY8Cr5QLz?=
 =?us-ascii?Q?gPxpyfrGGRRtKGHsVeZxk2xe9wPD4TOuXQGe3SUkaVc1zAgK2zhfKVZXDIDJ?=
 =?us-ascii?Q?t91APav4cKBy4sp2+nSdWaB3a9eC8ZjxCwDXyz6bHQndesfXTApC3u2Haq6U?=
 =?us-ascii?Q?OWCf0QMG2pA/8fgub05Sl1AfWG/OdUm9Tb1kHXMsd/7E6XSbs6z1lLT3bC/Y?=
 =?us-ascii?Q?z8a/nRvisty3ws8RrizhZUZMJ2UwotK+Smccon6b2WaRTwN3sEi0y1yViyJU?=
 =?us-ascii?Q?xriUX8IFzyo+v81CFdAjatMqXrUzreOU7Iv/q6FOy8dnY8omQ2ITZd7+STwP?=
 =?us-ascii?Q?scq4bKC1Po2StBVx0Pa8TjC5ncf4qngUSzASSTz3A0Bmbsph6rqZ8KKeDKnO?=
 =?us-ascii?Q?ElQuzblLd9ixdtpcno31hJCEnYXyPs0L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qH4eMoyEU6/0p1EVOOzb8J2/F8DoXn86LzGTHo7aIqvxY5Gy3HY0aytQjr/Y?=
 =?us-ascii?Q?xsxGZSMrpFxl/R2RZCRgKPIrl6v/OrowwS7wuBjZ34yie6h5CLYavBQOH44M?=
 =?us-ascii?Q?TBnMhk+mHDz2RxdKNmtHiX8aoXIxzpZnmiSlyUnfnfuX1a8mLvMZVxv3f1Ux?=
 =?us-ascii?Q?qeKL09uK3FbjxG48NYkBvXQ7A2M6ABKM08tWrXop9eblJ15v4OupL5QHgas4?=
 =?us-ascii?Q?a+ur1otXF0PjxyjXF4M1bg/BLXwP8NLZhj+2fWSdYzb3SL/aAvujf3Hph94u?=
 =?us-ascii?Q?Dge5Kx3ZYC7jB2nS9D8677tgEd6rvPhf/edhtMM+giIPjz1FgJ9FP+VfibV7?=
 =?us-ascii?Q?uCOqbZUen844AAvba5jj0Rzmq6FJyDAJlAACZDiJeX/9SfE2MtFiXk1XbQzB?=
 =?us-ascii?Q?53H0wTazlnC727C+2MsAiZJ3F3ZMr/5iJcUKWMct/iQfp9KpImrXClDOMltD?=
 =?us-ascii?Q?3hrw9trldAF/NdvrE/CY9aXxE1lTPi6BASEwm966Ro1242Iz+SlKEyZRMsBE?=
 =?us-ascii?Q?9p6CZukOR+supf3aYPEG+R8+/1nCr89y5LNqO1JdkRzmD3HTU5nBc4wHB7TE?=
 =?us-ascii?Q?g6KdYa+Lw6n24x4+BwpTZ84kLOeErmcbeFRLbDgdl3tZgGVxihXRRMOGYXU4?=
 =?us-ascii?Q?HTmsZCZMCPTunppHnK/B3n3pVgpRXYFsBE9rJ+XqTpvf2z93SFJULm2cAMLL?=
 =?us-ascii?Q?c8TMw3qrynwUDb6traV6Ha2jbbIIsh+MtEoWXSa/lSoKIAL38dejVRf/Qh06?=
 =?us-ascii?Q?pOHJLprWStDR3EUfE37dJFxEIXqy1T2bs5xD+zisqG+W05dokXX3Oa9l2dti?=
 =?us-ascii?Q?AbDZWFVigp3KDvY1py7bZ6TcFEEtFPW1CZk6jnK+sM74640FDDUFNgPHn9ss?=
 =?us-ascii?Q?WUo+Mo2/dcNkf0KIcvr3xjC9EaxhhRqY9Mkk2DuXTFGawEesYwlDqWoI66xq?=
 =?us-ascii?Q?iilKYGlirE3GpapjrSC1fpXT7pfHhuunn/lEnz7d5kjHQhrRhd/yjg50m4Yi?=
 =?us-ascii?Q?+Iu8oZn2X0UuTVMAu9QBtjoPsc+ZGfS/4QNdk8MjxqTTHettvTb8R7E/yVb9?=
 =?us-ascii?Q?TDMDYe2URDP2flleRBYpH0Gk4t82XarTYqBNSrUlmyEPt5+cwew16w47OefR?=
 =?us-ascii?Q?2VzZ9JEVSz9ux+zGGCViE5rTxEam5fTbL86CetiieEwfVTOeP98TkIM5GKz3?=
 =?us-ascii?Q?AqhJFtG9vUKptQ0Rpp4m9a5c4DBD61aRlwxM/t7+2usSfRJHSRom7Mck7+sp?=
 =?us-ascii?Q?jaquqEGX5C25IQ46pbYEGX9hsIWgPsf+NKNc36YTcHnHSf97CTbQIVMnqP3N?=
 =?us-ascii?Q?MngVRTZ8JES3m+TpBfxz/q87BJgpNSyPvOTgw57XQW1B3DXVGng1FgwFjsP/?=
 =?us-ascii?Q?twQ0ruiRNJvnHhoKPSC/l/7VWQGxzuJGueBc9PnVcIghlLhxxoM1DvoI267J?=
 =?us-ascii?Q?2FjOVYKkxOnsYnofwMR6J3rD0BjThJ7pvDnN3JD1GDZ9qZJXRhoIHJLlXpCR?=
 =?us-ascii?Q?c0dpUGJbHH8sAEPoePu/+pgRy0prmhGwoDlsZ36Pbrq5cLYqwBfkzyn9FekK?=
 =?us-ascii?Q?N/yINs69+IU3HzxmwzGtyzh0Fkb48El/fBZ8S77vDIZfz45svgsFFi6h9dNH?=
 =?us-ascii?Q?xNCiRhx69ZlSzoQaygao6w8=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2384fe-1cea-47a0-5036-08de2f60fc09
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2025 16:04:32.5732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EhnSxuRnTsoW5FACGtL/olcr5tu2sU7nmUANnlnDBPM/CC6rx1UPWFkaBYAzJ+o2D5lplVrk3RFt8QSR3b0bwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4684

Historically both TX and RX have assumed the same per-QP MW slice
(tx_max_entry == remote rx_max_entry), while those are calculated
separately in different places (pre and post the link-up negotiation
point). This has been safe because nt->link_is_up is never set to true
unless the pre-determined qp_count are the same among them, and qp_count
is typically limited to nt->mw_count, which should be carefully
configured by admin.

However, setup_qp_mw can actually split mw and handle multi-qps in one
MW properly, so qp_count needs not to be limited by nt->mw_count. Once
we relaxing the limitation, pre-determined qp_count can differ among
host side and endpoint, and link-up negotiation can easily fail.

Move the TX MW configuration (per-QP offset and size) into
ntb_transport_setup_qp_mw() so that both RX and TX layout decisions are
centralized in a single helper. ntb_transport_init_queue() now deals
only with per-QP software state, not with MW layout.

This keeps the previous behaviour, while preparing for relaxing the
qp_count limitation and improving readibility.

No functional change is intended.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 67 ++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 41 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 57b4c0511927..79063e2f911b 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -569,7 +569,8 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
 	struct ntb_transport_mw *mw;
 	struct ntb_dev *ndev = nt->ndev;
 	struct ntb_queue_entry *entry;
-	unsigned int rx_size, num_qps_mw;
+	unsigned int num_qps_mw;
+	unsigned int mw_size, mw_size_per_qp, qp_offset, rx_info_offset;
 	unsigned int mw_num, mw_count, qp_count;
 	unsigned int i;
 	int node;
@@ -588,15 +589,33 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
 	else
 		num_qps_mw = qp_count / mw_count;
 
-	rx_size = (unsigned int)mw->xlat_size / num_qps_mw;
-	qp->rx_buff = mw->virt_addr + rx_size * (qp_num / mw_count);
-	rx_size -= sizeof(struct ntb_rx_info);
+	mw_size = min(nt->mw_vec[mw_num].phys_size, mw->xlat_size);
+	if (max_mw_size && mw_size > max_mw_size)
+		mw_size = max_mw_size;
 
-	qp->remote_rx_info = qp->rx_buff + rx_size;
+	/* Split this MW evenly among the queue pairs mapped to it. */
+	mw_size_per_qp = (unsigned int)mw_size / num_qps_mw;
+	qp_offset = mw_size_per_qp * (qp_num / mw_count);
+
+	/* Place remote_rx_info at the end of the per-QP region. */
+	rx_info_offset = mw_size_per_qp - sizeof(struct ntb_rx_info);
+
+	qp->tx_mw_size = mw_size_per_qp;
+	qp->tx_mw = nt->mw_vec[mw_num].vbase + qp_offset;
+	if (!qp->tx_mw)
+		return -EINVAL;
+	qp->tx_mw_phys = nt->mw_vec[mw_num].phys_addr + qp_offset;
+	if (!qp->tx_mw_phys)
+		return -EINVAL;
+	qp->rx_info = qp->tx_mw + rx_info_offset;
+	qp->rx_buff = mw->virt_addr + qp_offset;
+	qp->remote_rx_info = qp->rx_buff + rx_info_offset;
 
 	/* Due to housekeeping, there must be atleast 2 buffs */
-	qp->rx_max_frame = min(transport_mtu, rx_size / 2);
-	qp->rx_max_entry = rx_size / qp->rx_max_frame;
+	qp->tx_max_frame = min(transport_mtu, mw_size_per_qp / 2);
+	qp->tx_max_entry = mw_size_per_qp / qp->tx_max_frame;
+	qp->rx_max_frame = min(transport_mtu, mw_size_per_qp / 2);
+	qp->rx_max_entry = mw_size_per_qp / qp->rx_max_frame;
 	qp->rx_index = 0;
 
 	/*
@@ -1133,11 +1152,7 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 				    unsigned int qp_num)
 {
 	struct ntb_transport_qp *qp;
-	phys_addr_t mw_base;
-	resource_size_t mw_size;
-	unsigned int num_qps_mw, tx_size;
 	unsigned int mw_num, mw_count, qp_count;
-	u64 qp_offset;
 
 	mw_count = nt->mw_count;
 	qp_count = nt->qp_count;
@@ -1152,36 +1167,6 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	qp->event_handler = NULL;
 	ntb_qp_link_context_reset(qp);
 
-	if (mw_num < qp_count % mw_count)
-		num_qps_mw = qp_count / mw_count + 1;
-	else
-		num_qps_mw = qp_count / mw_count;
-
-	mw_base = nt->mw_vec[mw_num].phys_addr;
-	mw_size = nt->mw_vec[mw_num].phys_size;
-
-	if (max_mw_size && mw_size > max_mw_size)
-		mw_size = max_mw_size;
-
-	tx_size = (unsigned int)mw_size / num_qps_mw;
-	qp_offset = tx_size * (qp_num / mw_count);
-
-	qp->tx_mw_size = tx_size;
-	qp->tx_mw = nt->mw_vec[mw_num].vbase + qp_offset;
-	if (!qp->tx_mw)
-		return -EINVAL;
-
-	qp->tx_mw_phys = mw_base + qp_offset;
-	if (!qp->tx_mw_phys)
-		return -EINVAL;
-
-	tx_size -= sizeof(struct ntb_rx_info);
-	qp->rx_info = qp->tx_mw + tx_size;
-
-	/* Due to housekeeping, there must be atleast 2 buffs */
-	qp->tx_max_frame = min(transport_mtu, tx_size / 2);
-	qp->tx_max_entry = tx_size / qp->tx_max_frame;
-
 	if (nt->debugfs_node_dir) {
 		char debugfs_name[8];
 
-- 
2.48.1



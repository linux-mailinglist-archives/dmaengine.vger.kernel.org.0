Return-Path: <dmaengine+bounces-7787-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87523CC8F0D
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 18:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9743731AE8DD
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 16:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C7533CE85;
	Wed, 17 Dec 2025 16:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Aotw2lC6"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011059.outbound.protection.outlook.com [52.101.125.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2014A34889A;
	Wed, 17 Dec 2025 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765990226; cv=fail; b=hucYquDElPxdq/nLuGlCgyzMy6xPql7d2CLhUM4Hz1GIFqQcaLtQLfvzD/+J9MVwerUNg/l2V/NtQJlxKEcGv60+3KhcJzSLwrozS97lAzHU20tqAEL2NONrfIo0QSbcuKOn9DBYAdCPbS6km6Z8j0I/k8r+XmfcfY6IeVLT/h8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765990226; c=relaxed/simple;
	bh=D3P+3vigCpubVyho2RrN9mwEodfy7YGO5ZpJeiXYFY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AJlnH3P63AhTxS4isyMSE6S7gnqzDILPfYLfLky4/q1Cu240YU6+RdvzbuHRRtOTE3xCWfE2mW2ogS7Vs6RGz7OE9fpOGUn9IEsWqxZBBJxOVqb9wmHNgkAtp0yzgZbii7o+lLnAq0Tdgx6xyGRLbP3keQH/UH7zA8xKHAdqfCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Aotw2lC6; arc=fail smtp.client-ip=52.101.125.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWUT9bcPegmvVyYeRfUJJeFN4SmAwax/0y41DDX6KBvxCrxSuAjEuH7I8iJg/E6dGTSs0SfYhAUHGAAV8/j8b0JqN4XUVBvEq5gOEtnPDx60N6kVeh3szxqYDuPKka+8lh6oeUfuLzj1Rc6T3HT3il0J0ui+79vcahyz9cvU8Qaa3Msp6mHEdT3KTdRBqAPgYF9/IL4pse8H8vMCmeWFsjmnutZTO1Q6OsrUEqP8PyIDCUtYqeGz+SSFMe5RppBeWQ6y246IBIOLZPVDx8NRMHrmElGkSNBgNcXlsdeTaorEJHAOKeALkm8+EierGqR028Ww7fNgUJ19D4TI6MMuig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBjs62C63/zVf7xG4DFNs2yiZxHTrjLjAG7M3hlTTLc=;
 b=kV0gLTP/P7+s3bBuCkD21IeDeORgRWN+8ba0ysu2TkLz39Rnb4kh9ChNRsw8AhbweMBDg6lW9MFu7MwK6z5pL9dS5NjJFNpqwn+wPhS4nVs4hMeQ+uIpw8Rl5RQa4e/271muu3S+32sjeB/MEiXtVACTJoFuPHKEYy1C/Qswg46iBAo86KDPftphUcONybiQiUdqxDBdyI4mYG1u+DPOjkjVPD5cCnPu0PBEuzkJByDO/0pOge19ULMOkSn+y6yGqV2r8Cl4Ph3FXCmBN0VJLoBzHmHrHKgbdg01dQp1sIcYNXdP68QOwtGBbQBPVt8Q+5A/RQLQhc70nGA+msloSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBjs62C63/zVf7xG4DFNs2yiZxHTrjLjAG7M3hlTTLc=;
 b=Aotw2lC6WsUEzi6bEMB14J/Jtcii3Qqjwvn9vJhEqkNHSNSr6On07hyVRaGcs2VSECZ1Y7ML5+xUkqqesTORKjKOUrvofoq9t85jSLCjUSW4d/A2Gek21rUaGLum4Nu+Df3jb9KveuL1eEiUh24bvsMMFjfQJo2pCgck6KTnie8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB4633.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:16:17 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:16:17 +0000
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
Subject: [RFC PATCH v3 05/35] PCI: endpoint: pci-epf-vntb: Propagate MW offset from configfs when present
Date: Thu, 18 Dec 2025 00:15:39 +0900
Message-ID: <20251217151609.3162665-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251217151609.3162665-1-den@valinux.co.jp>
References: <20251217151609.3162665-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0130.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37f::8) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB4633:EE_
X-MS-Office365-Filtering-Correlation-Id: 65fe181c-7acd-4b78-48bc-08de3d7f3a11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aPe4SKHhAdv7KuIbQhPT3EauF9OqoPEl2Ykxv1SQZvJsohqIHS+jiWeR4XHJ?=
 =?us-ascii?Q?moT2l9f3gq93yEVIu4/FtGHVNmCyN+HBlfs+OOFNhNecU13/lQ1q1hbrHHbE?=
 =?us-ascii?Q?VY1tX3kNI8hzU3zEzZb73iCkI81sOqrUo9X6kwVOFPEMtJnbmy4c5McLJnen?=
 =?us-ascii?Q?6ojLkzrB9yZ1KcMp3lcRhIk4SORbfesTLN/CxZv1/1sZtjkSfiBB1R6BxZ91?=
 =?us-ascii?Q?3YnsEURBoFzp8gAf1Rd9GPx+mSJqRjnVc9mjFHXvE/twB+qRakjWMKG/0p9S?=
 =?us-ascii?Q?DMZxvo1NVXtcvEFQu+iyrdG7WBubP9bay+WDj7EpGW85TjU52y+vu96x3A/+?=
 =?us-ascii?Q?478pWclfAJ018gIYMXo2TDhQbrWx7euBTK7ftFcshQGIjW1WVgWssPHnAqea?=
 =?us-ascii?Q?lxcwxRxQcMEHHi99WrwqvTeJ7arWTPN2VyQC1EagJODG39ih19lVaw2nGD5I?=
 =?us-ascii?Q?mWbV8UTOYN6O1KRDkqzu5TrYN85fTbsOa9g4tlhOZiv3x/Mq3Ot0RCHDQA5D?=
 =?us-ascii?Q?V0B8XWVBPUudxS3moE495PBnt5nfa4t6JOV6fNaJUjk7LSjWpM7Npd+a9HfB?=
 =?us-ascii?Q?PVGQQWIezwM2A2vorAh6qjNr7y9maWxSS+67Bc6FGNnPdblxyPUuoV2lyJ0w?=
 =?us-ascii?Q?IZV8KZawW9GC4DsjEsW0Dr+7VbPMv9sJyzt8VuR5YoEpTjF1KoEoa14YHlsW?=
 =?us-ascii?Q?BrzriJWcw2Jl+zM/TV+4liS1Fo0AGe1tOGgbbSlL4t+hpgrtwSXSuKi9NhiH?=
 =?us-ascii?Q?YCUBvdguEDeZENvn6ekJWv8/IvSjrWgWjj8h9H5s3EoduJDl9LYIl/qWytiB?=
 =?us-ascii?Q?BHDrLVPLG9y+1qcnpgP+eF4Qzy4BHh7KogIUsVw31Y4OmhjmSg1zsDSDu77d?=
 =?us-ascii?Q?aq1D8o8esIaJ/QghE9622Ojz5CLOrJl+f2O7o8W4Zc48HNt9HqAb10wPMekq?=
 =?us-ascii?Q?CoCjofJUTHlRFt3wmWHoFuyTJ0avsjgZjuvlO+KiN5OIEwHfNBIlFoFaecPe?=
 =?us-ascii?Q?h+7x+oXpfchlofq95IL3uFSXJFQVj+xsL/I7GVIs9qCVRxEZZKhiqQ5GvZWe?=
 =?us-ascii?Q?NQOB5VCR/b1tmAB2V7wHGp6xrxDXXV4Q6IEgpxpPCfAiAJalDxCNcOjLQJoJ?=
 =?us-ascii?Q?rcsd2nxz2t3foqH0cCqATPtTMoHGyR3EYplb0WKLgqMGVATKpDrS8l2fKL/U?=
 =?us-ascii?Q?3fJNLo09hCT+GV1zPj5GMqm835+hbdVcMLcKpjlNiB0NFNftrl01oohbAGiP?=
 =?us-ascii?Q?2yjy7iaoTctK/S6kkwsVT58U60Y1+ikOgq0Ulaxj3T4/T5dqgLdCALcz6mLH?=
 =?us-ascii?Q?w2ICts1YYBmpknN4QAn0bDb+GQwqYVg421FW37zsDLoxEOqqkc8IWce4T6i6?=
 =?us-ascii?Q?TP2JflgwOpRiyZv/8HTaIPK3dmPbU5l/rDopJPEFPcc5e6R2CbI62U+okjdD?=
 =?us-ascii?Q?4APWszrEAg5S/WAK7Y91DAwW2mEqwWvq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tIQfgKMrUD8E5tggy+JT/YttTX1GGMpvo243wtBbNEt4tnuFHHz2frIATksY?=
 =?us-ascii?Q?VSWzhxUDtK5WQ5wgStLprUYs3nBLbIPiRRgsPyc6GIKmNP9Am6/ULSAWmd7K?=
 =?us-ascii?Q?Mbqo9G7jK/LBMHACLCYe2mCzc8S76Jk5pyJYKVWAS5Uf1dtXo1cD1gr9pNsJ?=
 =?us-ascii?Q?vOskw+5cLTR3SH+bUXEC8tcReR34pZhtItx4CZvby3Ox1U2CRCHT4SwMFAop?=
 =?us-ascii?Q?+SNmWo126arasJjwfCFT9wdSiMVkzXOVEVtltxakSGOO4AD+ygeaN3e+UJYm?=
 =?us-ascii?Q?4XgoR50NSd5yC/yiVD4KuREIE6/sGMvWm0KUDUCOtPmuW0poxtcZdpNaH+lD?=
 =?us-ascii?Q?JemkDf8pu68dQ90bmQ7q+GvYjsj8elHpKMYHyvfgoQVc+mqKDmZr418DnLk7?=
 =?us-ascii?Q?9r9ZVk8b7/e9JLBo6jKksytymmyC04sgCXK7vLKn8iN8+7cUee5GT7HL8jGn?=
 =?us-ascii?Q?MrETeXJx7ujK1NfYvcUpIOgZwadHM24FxhL78y9lgeXd5d9wsuiE5RcOZZRv?=
 =?us-ascii?Q?0ZtXyJzfykhRs9gFsBZ+x8FL9dUzW8a9KuNF6R2QNEkAd12iNG/PJKY76+3p?=
 =?us-ascii?Q?Fi+t5VuyYf3UDIUNqyx9H/v0RDZ/Vp5zSjVwvL/lA8FqEKDVsjvlTxuPT2xs?=
 =?us-ascii?Q?m5bJbJq5pFXSe/qMnjJIwqFRzUqPP/gnQn5SyavQo/Rh2s7EBdqzigMQI5lM?=
 =?us-ascii?Q?YxVQjfydzJ24r/1jUE/uh8WguK8wgmCqkg4SkFnBCquzl4FYc6lh9fDnJYAp?=
 =?us-ascii?Q?fXgCHXvbAgdUUn7SIJCSQfg5R26LTMgZBnki2+pJHRJkeBEIe6LVFCZwNX7t?=
 =?us-ascii?Q?lOfshlbSAzULE+wYkiZ+PWQMPaVz9jsxQqwnglbifFvRrJDGQ2jqW9Grv7Nn?=
 =?us-ascii?Q?L+YOvhCD/p8GInG/1V4NkLgJbIHWz1JEdfibnGTTjF6/3cOaJO1S89HGGVAp?=
 =?us-ascii?Q?0CcwT/vJlei4E7XLrpQplFsTFC+LvBfSv+icJqFekgc8Y2jqU6sxmLf2aSNh?=
 =?us-ascii?Q?UqHCYT4R7hYBZiPAs6jYNiQzWouH+WEyjnqvbnp5L8WHNu2PhcrCDGFg+CaY?=
 =?us-ascii?Q?7bfxTWqtpRvWv8lQr0bekmlCtvpnggMXe9D12EMbDZDg+7YuYse43vR5Exwh?=
 =?us-ascii?Q?dM+u41tWMrNi1rsplJgwIsk/Pwzp+v8cJ0Yvjxw4egR+Oh1kk8DS7SVsOMKl?=
 =?us-ascii?Q?wvI4tWtla7vt13OfiU8MnEz9sk8yimiMxYE4MS2vb6uf/3mLCTUz4kNkpR5u?=
 =?us-ascii?Q?2CmXQ396agdS7RhUUNvpi5T9+9UuJhpBOJ9d1qAwZZqOIHZYCU6aQ6lgsfOI?=
 =?us-ascii?Q?pt9VwQiuuEMQ6C+r53g7jW/LZ27knYMMHKxs7lC4wgVMb4R1g8Pqh00C8ofT?=
 =?us-ascii?Q?y3b6Pcrafb1FcD83IgPiFuxjVW/Cx1iRgcmVcrH25kgoQIdur3W6DwzvVu42?=
 =?us-ascii?Q?By06U/NcIJasY/0y14Lqawsu43fuI1BL8wXwZPkeVh9tUI35qeuj+mfnM9rr?=
 =?us-ascii?Q?Aj/HNRcKlDx8gsxXD22FwkOZlD/APIHMFhCIRotBNNb8xCW7YAsZ/G+XY4Kg?=
 =?us-ascii?Q?ZPHboTPE0ucrfJ+LVjv++OtbK6sXZcLJBeSW6uwd2s7eiQ7kv5cuxMPYULw4?=
 =?us-ascii?Q?/OQj0fvXr16S+yf4Odo2Ir8=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 65fe181c-7acd-4b78-48bc-08de3d7f3a11
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:16:17.8388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Szeipwn7ViD+rORqRDQdlpxqRnsS39DcNEs0QJchBxrk2Oy37lVs7cUpn/fHSCVs7GkINYNpqPT6lCJCytIMVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4633

The NTB API functions ntb_mw_set_trans() and ntb_mw_get_align() now
support non-zero MW offsets. Update pci-epf-vntb to populate
mws_offset[idx] when the offset parameter is provided. Users can now
retrieve the offset and pass it to ntb_mw_set_trans().

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 4db1fabfd8a4..337995e2f3ce 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1521,6 +1521,9 @@ static int vntb_epf_mw_get_align(struct ntb_dev *ndev, int pidx, int idx,
 	if (size_max)
 		*size_max = ntb->mws_size[idx];
 
+	if (offset)
+		*offset = ntb->mws_offset[idx];
+
 	return 0;
 }
 
-- 
2.51.0



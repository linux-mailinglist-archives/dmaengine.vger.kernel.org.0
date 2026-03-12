Return-Path: <dmaengine+bounces-9395-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKYWI9DvsmnAQwAAu9opvQ
	(envelope-from <dmaengine+bounces-9395-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 17:54:40 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8A7276043
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 17:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF029303D31B
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 16:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1833F65E2;
	Thu, 12 Mar 2026 16:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="OXiyZ5Ra"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021104.outbound.protection.outlook.com [40.107.74.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD3E2233A;
	Thu, 12 Mar 2026 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334219; cv=fail; b=Msxc7cwpgIjT9Q5d0Ez0NyjAkjZX8iLFMtJtZUsFeySL8X5NPh6QKPpATTFKxOxF0NwD9F026mIwR9XXwVLr0DsOyWcmDMTE5xHGw+z0ktZFwOQb2EiQm4YX4L04Ihdqo1jBjyB/h6RcmiKfzN17MRVeDbYIbDvm4+cd3zRToN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334219; c=relaxed/simple;
	bh=uzBM3DrRb2s4I9F+YuVxR/MWL+QbwJ1CQ/uiTyoBso4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oYj9q8Etc7Y4Z7eq/NvU3v4wEteITeIGge7EZpYwAadvgbAv8t9XVxS/BKkk3T5n1JULQDGT/4kwnW+KsPGqej+vD/BFXWLOa4cEAtcwgzwxs1LqOUcnehwIhEwTywZxXQHJU8O1CPb2vbciHd1cnwgwF32OpgpmA6oUyalAQxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=OXiyZ5Ra; arc=fail smtp.client-ip=40.107.74.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EvPwpTrMW/AH49wwPBQM4JArMwcKZ6qPuT4GRXbyzfTnpPCK6FrbmyoXvCub+fVH/nBYKLnjueY3KJ4zTvLVg7Wmls1+RusCOwozZa5m4Q2Ce6hGOTz9kOAZpmRNyF/2i4+0Z3+3PISh/XRw32bHN8WZKRTUFbSt/7ZIheErYpDSPKyjMxEKhSomR2iU8KOOSG2Qjyw3Cmi8EmDREvPytn9wQD3fvXxp8X6GtVPib92ud1rZ1xidbSDcwAMOcF8i2QVjkXuQJt9WjgDGRkHWxPyHcaV7xnzt42/5c7A8/iycWlojVSjumSiYWo74FYoXRTDulUW9WvYiZpR6/OMmwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2Ojd+91uM5lBJbrfmod8NX6oNM6o9ytEhQYuhC4bJY=;
 b=GlYOYZizFrdWKHakHNgMC/Bm6FxZ17+yoGtLHtfgoTRtxRhQXUEk/TmvkcFpkkgBZjI29LhZh+/IkobmpaU9Um4IWAfxJDciqFtSCJ5w7WGHtmi+taRjk6Y0hPBMlu804jeahb/yt/jIM5tRWACBzaLbk/NvokTa9+cC4Qz1r9/RmKM1Tv9g+lyePa+xM/Dq7/nArGjAdGUqj4uGE2lG/kvzibvjn88dNlUkVD3kDUBPUVRxRa+u7k0ZzfZu+r5LRJW4/RuvV4q9OKyKlwueuhdVPIk//LSXEyw+T8r67iOG5JeAej4xl8K7pvpVGpBZ4oEGydB75Vk3HV8uTT5L7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2Ojd+91uM5lBJbrfmod8NX6oNM6o9ytEhQYuhC4bJY=;
 b=OXiyZ5Ran9HCF9aboSp49Cs1MV6w3Ga4xyHDsxsTcuH868I2mv72q8iyrndQ5bUntDTMUa+3RNFj9KasfzC1jD31OrbmKBIlHPcsXdGnPdIvaOmIz2DKXmxwmPNdjGnMXwNqFl0XbW8wIS8SIQmzI7IrJ225WciKNF7i89Ym4QM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2018.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 16:50:12 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 16:50:12 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Baruch Siach <baruch@tkos.co.il>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH 02/15] PCI: endpoint: Add DMA channel metadata to pci_epc_aux_resource
Date: Fri, 13 Mar 2026 01:49:52 +0900
Message-ID: <20260312165005.1148676-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260312165005.1148676-1-den@valinux.co.jp>
References: <20260312165005.1148676-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0064.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2018:EE_
X-MS-Office365-Filtering-Correlation-Id: b7192eca-7bed-41a1-5e6b-08de80576dd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|7416014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	viH1q2L4+E2PmPFQDVudRxa+3Y7ynLgSIYBGSUqqdYSsqX2FbBzejKDwHdHOcm1kjzBxb3iCUgcB23kKqtTWME5nBLeOGhJ5nMrRjYehfLWQlMzaxQ75eM87hfC5+7IKjvCCDvLo1Bs9Zbo04IdNAdkq9lDGPtm+4dpKY+ISzvZU7ycT1ctwrSs9XiHROLKdeYgkO25jHcg7oMqsdMpG+xDOlpH8eYx/33gS2qYSI4qExTlWBbWP8XJnAs2c/w3gjfdarJ3ACC1v4IHfHFcX8lmOiJso4tlV3GTjEfrACVCJjyQ25CYjQuH1oL9+QkZNURg18biGsoASHXIEgwNSS01qL3VXgNibTh4t5lq8IRkPrx0I5VaTOULgUyDjNELFWkAkOZJ/TeMVhpqH2DCaa73aTXI78aXQlDEe+fohhNkjWBmOasCuyF/uzSxRDNLFa9m0HnpE2drGqvVuOGad0RvDdu4CRdL0W7fIjt/IUMwrBnQiEFJssiVHUCq4324N0YqNo8l/bMLoHsqCYN6aZlFsf/qOys4lJky6R5F9p/xiztcfznE7NW2RRppPJ34di/KZgtcMhx1UScQQtFrjssXA/fzwzNtwOV9Rc7YgQHqikOnWREZlHYkbi5KvZBIJsTViGsLihtjL7/VD89dy1F5d32vzzZPLo2OV1ii+hWokbdMDyx5vSdJoYquAZPqmDFp1U3Am2IEV07vgWtyRZhUInx92X0jCE1fIwgxdNl5/yQk5UOv4UqZp5pIn+2Hy8v3UftO7nsEYBuZ2Y+JJkA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(7416014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8N8gX51FzA4EfgWFFX8yU+pc1vSICEzfFXEy9nwE0ybqkapBtnfcLY0QM6+l?=
 =?us-ascii?Q?1Gx6agFCZcwJFd5X+stDScA2tUqjTnIWMP1Fx1UkauIvKeAPH3afq21sP6HD?=
 =?us-ascii?Q?YrO2MYT5iwxFC9wUReEr85BcEfDzhFKJ0FeO10F/nUxlsXebB2z2GtiWeAlo?=
 =?us-ascii?Q?+EM/utljdLmwl3uLx8KteEw9SfIbjEcgZXwqj9HffaMbhTOwGSLrNqIQ4FfU?=
 =?us-ascii?Q?RLor8uXl2RykfWhYZH+KvFX3t2LD6ksiOvGgPNIQPeU9Ev6znIuTXxKBK87V?=
 =?us-ascii?Q?ov8CknQinYlcH+Qmmo0MCpctHHmUkRtFdhLv63+TJEuuxxm8ziMuf5bq2ynf?=
 =?us-ascii?Q?J+SBwANjqG+BC867QkIjmzrzPAOulPqKWPzezC6jj7IEbexKTUj/jCK/EAPI?=
 =?us-ascii?Q?2iw/p4oXIFR0BRUw0Xa7QnXl30e8XR0YHOnzgu0tgqhtENuNCCl+ryC9QGsw?=
 =?us-ascii?Q?xw48eyOf+r9z67qNT2JNOj5IYg+POFBPa3F3i4mwhG4Zys29n1Db+7/FrLfA?=
 =?us-ascii?Q?nE4fh5aO2fHpQlyY2/QHJmOeMTGtYVoq2LXw9IuHbzoIw78WjHhgzxePP9Pt?=
 =?us-ascii?Q?4DnuxS/hGjCN/qx1hW5MwBVHmm7AUnc80zxtlAAYCZGuyjXhsSgNAR01v8Ym?=
 =?us-ascii?Q?pkhTeA+nBJiSjT12L3gHv5f5VeolUKdpz1VfIxJB6DeUuN0Lww/ItOWs+DGE?=
 =?us-ascii?Q?fErUyrN9OYhJkhUJrL/rCw5UrJn8Us06P5FSZKKhG9hWWVI00eaLbgnsdpVp?=
 =?us-ascii?Q?Rr7QqOGdeGiIBE4iGSDns6woTDM0XbsESey2LIn7h5csSIxysuFpn0S0aLsp?=
 =?us-ascii?Q?YVB/ySbv+MYAKJjxgg7GUBHnp4mTWBNX59QTPAvMvDiFkIvkHtryNkgOJPaN?=
 =?us-ascii?Q?A2K8vqTJUKNmMfwREfneMo3MxK3MNLi0yGIe+h8C1v7z4LqU4kDXCtzThOnF?=
 =?us-ascii?Q?4sr7SJs8AiRp8YUkPuH+5wk8Mr5/HDQlwDsGGvOoLgSqS2yCn79PbAmEuZcC?=
 =?us-ascii?Q?XNj0sYpEZoguQ4as9icFSIetKwiJIIlRJfXnD+DQqIiC9krjvZ894o3jJJJy?=
 =?us-ascii?Q?RZqLIDmESOfR8c/Z0MxzrXXFQoEsg/ngyUySloKyWASVZsnMQr1/+sFMiaaB?=
 =?us-ascii?Q?PscxdCaNKR/YfvV/2tMDm5OWir3xsymgEQIJk/DE5uKemrXFbN4icS1sPFtM?=
 =?us-ascii?Q?XSJ4/pNsrv2WJcCXRBbIs6OMMD1B80HbO4FnOkbjxNdbN3JS5ZrvwnHNH6r1?=
 =?us-ascii?Q?+J7HAFSgiYFSN/p4JtcIm3wMeUUibwiXnR1FbwHYpwxvG/PAH6MnWEmi8HFI?=
 =?us-ascii?Q?MyO8hWZcAIN52fMTioitrTtq4lS2+enStQNpEvM/me7aedzEmtLNaY0OE8da?=
 =?us-ascii?Q?N4rl78DY8kMj6+aDYSoewYJaF7yf3M4rH6lmqyQch/CZ0ouY8TkQuqSq4U0l?=
 =?us-ascii?Q?PSotmpaBlQbM5i2DVKN8hoeeSiCTmM2TEFsrPIOi54sP/YgT3SEKr5L3wZK9?=
 =?us-ascii?Q?NcqfgTlroeKzcdoa5RpMv13K7lxDGbnOaN0Do9hYDpoZ5ZUp2T22Oafok/Yn?=
 =?us-ascii?Q?SHAhi04P0oJHqOD1tbxO13+rDxrD0Qk9aFCQyKKjr4rAZ/1CMxxohgYVTZSK?=
 =?us-ascii?Q?JOnm6mx8jPMtuxMXTCv6By+5KxGhH+gMZq/UUa8chcr8Obo5e+2rtIIL2bO5?=
 =?us-ascii?Q?LlDwfGzISvUNywwer1QJspYrHERLGciONW71AxYtF7b5c1cITUk6tFPPwabh?=
 =?us-ascii?Q?je06iwURK9yHt3peP9go8eqFvejSNe7YfGd8dF8ZgxMb9qgQhfHD?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b7192eca-7bed-41a1-5e6b-08de80576dd2
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 16:50:12.6710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/MuvbP9zXIRYTOJtjuh4oRhWJIwJziGgenIk4CtSJRiGR/Jmp9681pjxx7g+mDtKpup9v/bc/KYnerv0WX+ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2018
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9395-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,google.com,lwn.net,linuxfoundation.org,kudzu.us,intel.com,gmail.com,tkos.co.il,baylibre.com];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2B8A7276043
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A peer-visible DMA descriptor window needs a little more context than
just address and size. In particular, a generic consumer needs to know
which DMAEngine channel it belongs to and in which direction that
channel operates.

Extend struct pci_epc_aux_resource with dma_chan metadata for
PCI_EPC_AUX_DMA_CHAN_DESC resources so controllers can expose that
information in a uniform way.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 include/linux/pci-epc.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index d6b0a0833e9f..7dd2e4d5d952 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -78,6 +78,11 @@ enum pci_epc_aux_resource_type {
 	PCI_EPC_AUX_DOORBELL_MMIO,
 };
 
+enum pci_epc_aux_dma_dir {
+	PCI_EPC_AUX_DMA_DIR_READ = 0,
+	PCI_EPC_AUX_DMA_DIR_WRITE = 1,
+};
+
 /**
  * struct pci_epc_aux_resource - a physical auxiliary resource that may be
  *                               exposed for peer use
@@ -103,6 +108,13 @@ struct pci_epc_aux_resource {
 			int irq; /* IRQ number for the doorbell handler */
 			u32 data; /* write value to ring the doorbell */
 		} db_mmio;
+
+		/* PCI_EPC_AUX_DMA_CHAN_DESC */
+		struct {
+			int chan_id;
+			u8 dir;
+			u8 reserved[3];
+		} dma_chan;
 	} u;
 };
 
-- 
2.51.0



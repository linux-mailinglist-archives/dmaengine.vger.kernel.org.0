Return-Path: <dmaengine+bounces-12307-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9hkaFTGwUGrq3QIAu9opvQ
	(envelope-from <dmaengine+bounces-12307-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:41:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AB973895F
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:41:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=A6rWcedG;
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12307-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-12307-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1732930317F8
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775E23F0AB7;
	Fri, 10 Jul 2026 08:27:43 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020121.outbound.protection.outlook.com [52.101.229.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F223F12DF;
	Fri, 10 Jul 2026 08:27:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672063; cv=fail; b=Nq9Jg1tiqs5MKp14XxvVTt6hgx6NrqH1CQkk5DJfXoAkq8ufpjjDhdjh6ilFM+3U/XiK4zRIURZfbOFRqhRByRIATMLQFUPJAuUCWDCVThZnBUjBtkkMJDFJR241cuPPqZ6pFxiwlhLBLVV5O8sbQXLP89wl6B9UL1z7OgzW2qM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672063; c=relaxed/simple;
	bh=CX8jS9Zy78UN1++AnNIZCb4w1noQHAGXNC2E4zvpT0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fmWjtnYiN2BDn3IOxfc0k320YB8OMUWW+UfOUtubl3ZqsaJbQO4g82tsSa9zc5o6gvs+BdNstwj6vdiPHk+x7jUIUpPZagRdpZC7wIWJ5CQjZI+MhQk9Ww0kFeT1UrJreePt2hzjL1EHKtDBqDb83/HJ+pFn7wIfzNVhYMaqQio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=A6rWcedG; arc=fail smtp.client-ip=52.101.229.121
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dr8NfSeLEhax0E0i0YHFhQ6soEdGSIIBaIpVY2c0ClEA4weKu6PnAlgmAg9lhjXmacIAeBiXrxCeAV/Jdsd63pDkuwT9TtWpXQKLcCgpi0WT++apBhUugD7GUsn+zFaHh+7JPbKYvLyEpAxUbsyPM8I+0Jvl5ik38CQ4sCL7HHUjEI4OQpMjyqB4ojClsX5SVr2PGw/WGXtl+EIapZ16fUnawFRio6eN1NFp+0UBPPYW6HN1tdoPRKDorAR0Tv10hcWl575g/5FobSMuuFeWO28HoB0NxbIJE/SXfeE5nF6re9JrNkiSCaXtvyXnmY8NiihDCIvws66cBQ3BJIx7cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYqJ4V8u2IKMw3b/5v+fhrYDjQ8GtQ4Rt4Niz4we4qA=;
 b=UI3aRY3EnAS3PDJ0DN3d8v6nFv90x5XgV6K667BdeNGXANEx8FS7UEaKHeHLfP5EVqdlIJINb3+thUsOnSVsQWbB4NWZTYHbM5ZWResvGv17ymwpaMQZ+n/x4w+S6IMf/WaapVGa+G22oVBKPwDW5UrRVgZKQSQJiJ6Lg5z3rwltt4480lWgSU6aJ++K3I3fTtXVweCbmX9AF3TDIUI7jmylhysFaTy/gBpNXTICIV709dXj21Wr5bub//ewKwx518tgkOLnh7iaLtV9nJjG8m3Jkf1xzvb9F03VlgB4Rn2Xho3/Yj26HQytHiyrIqwJqjGzHwBcd80VNELh5FvD/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYqJ4V8u2IKMw3b/5v+fhrYDjQ8GtQ4Rt4Niz4we4qA=;
 b=A6rWcedGrwbHXDhShLskOJxRebbZxl0MDTBUCuOPH4XzDLSBtAFJzrM890Cheom+uv8RRURnBMBiAqOm7+xiVmlLvKzypWV+W2KrbdcDBdD1rCH9/IK3eb0GvGys7U69TC69q5ZNjUBqzDF95Z4FY8ZoutpoLy+v/pWFjfCbN1k=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7001.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:433::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Fri, 10 Jul
 2026 08:27:33 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 08:27:33 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v4 2/3] PCI: endpoint: Add DMA endpoint function
Date: Fri, 10 Jul 2026 17:27:26 +0900
Message-ID: <20260710082727.2397253-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260710082727.2397253-1-den@valinux.co.jp>
References: <20260710082727.2397253-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0282.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a8159f-b303-4dd3-c287-08dede5d16f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014|23010399003|22082099003|18002099003|5023799004|6133799003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	UUKI2yaJ1vgT/fRQ9CQ+EU0QcGDeLPDVb8vvJmVpCXDRAYZlzBBb0Fki58Fsk72XROUvkX8hCkzx+iwdDp02Qvq/WIX+jh7GwSXk9QU9vhjLrr0NaY7b818VqSOQ/q6tunjf3fU9/ikUPiGPsGfLAAzWFnJ1ivMkFhl9VOs4EKjddXTiXvrZUMNZe+5kDGOiRAVT7/RveYCuZpC+HiJZZmElfmi/MDWUiq+K9/NNwpAKv1aPp5AdU58qKMK/1m1SwznEuKsoHVOIpHYkKbLCtm5pp2o9+ugUFDJ+0RO0ZeGy4TbOFUtx7VZCUYHUcv3iSVAG/ZgBdB56dmuktloVP6oV107xIigOlG3Y4ZMGlplM+otiw7tV2QA5gYMSqMoquQnphH0142ifF4xQE8NL8chu13PM5QmEaVMjloIEUpW+vmtknxEUA80bDTnxjCbDOCPRGmNgoZ11TG3M/HlLc6ywNAxaPag6Z3sL96JKq4fJNjfrojeeUJRrR9ecShZIS2llq3cYFS/SLapRFMICYVnijAPXbn9OFJBfzgB3PjsHsFbAjStMOBbGEEw2HLh6LdSKD66G/gCspGN4MuH4UCwtQX+F+U5LfyDKQBe8EVVZW9+sFrono79zJyWOd9Hu6UMJc4ITWigig1hE9hF73bxHLgFpb5dioiWARcuIPE6VYXXo1zy29jVbrsefMIp0AxyXuSBYOF7Yxwnkplwo9g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014)(23010399003)(22082099003)(18002099003)(5023799004)(6133799003)(56012099006)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hol7IzpLC62xIwtIcUVt2Lgl7aXeLktTd+fqSJnaKlGR1uwdx2TVBXJ/PG+T?=
 =?us-ascii?Q?wywHBtB3pfmCWiNNduz2HYdmx1wh7qIIJ4rwH3HlXX4vFaWfxc9xJrcDpZPi?=
 =?us-ascii?Q?KmKmqh2/QToEr97aqK+fSp0XUx7fHZkeBpQsgq0u+MjdTEXLqYEIJOW0p02b?=
 =?us-ascii?Q?Ob/3Yzv8XT9Aa02fBERTuW04Z3YaJJrgIOol7bHT+0sJWpxqayvGcaJwXbl4?=
 =?us-ascii?Q?zlKY7s+vzga5/VWXfOCj8H/DYKWTTLw1IeJbqgRKm7W8Fyh+gm5OuZE5NpQK?=
 =?us-ascii?Q?UaETvN4wpHqzUtK+UqMN9A6fEEyFPY6cmVi/vQMLShQQLtJnEsyL6Oiitp5p?=
 =?us-ascii?Q?kiMW1t6ccOxmF7la/FAg/zGFWYp5xaN3nxTIAXAB82ZklSbJU4/NT+AI6COU?=
 =?us-ascii?Q?3SNAsoQ7LIiyJXeFNPqAXs0E7reBe3nsZvNfdWSWoCrO2rVv32y1kE4jqa2a?=
 =?us-ascii?Q?d3oreT1nPfbU605iUQanWrem//J0B+nGgmIh9c0J+lgv266x5CM2HBZV7TZD?=
 =?us-ascii?Q?Ra59IYzrk73pEZwmS7TOGxbtnEgx93RAvJx+GDm/Yd/1wl9B+0DAzAY15nyj?=
 =?us-ascii?Q?jsm1GXx7DvtQIq0bJwfii/LpDHgwh2iOLw2UiuePmgw+uua/iI9WlaW8NnMF?=
 =?us-ascii?Q?n/SOdGllY2whtodIzq5yeQHLfMN27I7y9L8Es13lw0/dVT3BGd841wLur1Yj?=
 =?us-ascii?Q?XMTxUboh81gMSMbL+ScYnh/9EjfRDJE03/c8F3sZ+8HbL+iwWodHyi2bp6RI?=
 =?us-ascii?Q?oe8t8IThUmaGF4XhWERqdiLfXI+x+V6geFs6321DzL0BaEdNjDIuiBGroNVB?=
 =?us-ascii?Q?qzxjTtZIuEZ4YqvIosdmzTgLMK5eZpqiVfn19cQxEl9ASE7WFV3qytaMXyap?=
 =?us-ascii?Q?eqxKLVDwnDstNlL6S7CCbcAH+lSbizLPhAJ5rLr3GT/Eds+pI9ovJOX+RWCq?=
 =?us-ascii?Q?jnk239PIp4hN0u2QKEyuGkuKpdQZxNvB9CWCpjL3BFDFJ4sEpGnDS0j6WV1M?=
 =?us-ascii?Q?jgsVBIKI2HvmqKZOpeUo4EMJMma2KJtdorFIBVc/XUw0jYHuRIrIe8iZ8CPb?=
 =?us-ascii?Q?RZ9ps/bu8kKZHINfki94Rb2v1P+xy08NFMtLX5FW2DU6V/DNLAxXuLxid/PQ?=
 =?us-ascii?Q?TNWEHXzb/Pow5zEVInE9l/TpV9r9OvqVIycUyBmUKziT9ofsLrPpY1SgnJiS?=
 =?us-ascii?Q?RRp2Iia5eWWsOMqOeAQO4KRmJZTCdxQatMT+Bs7QVx6vWsW/WcHtWTjOPskN?=
 =?us-ascii?Q?5ODW+a1FYSj4GIg0wsghL4kqZu+KHqujSVWQaKA1DAUgw11qwUhZQeeSCHDM?=
 =?us-ascii?Q?8DEoraD6oHe3j2fF2nwWDcLSPOFR71z1ILVb99oK1C2QgbJniQaAKBMzZILJ?=
 =?us-ascii?Q?NFVzeUsg97FhTKBIhOE+hRlCPp6Uo35rU+ccEARPMvktw+devArl2DbuRpiv?=
 =?us-ascii?Q?8CguC+O9QI92YLvT07h5j4thr7SESjDyAyobw8bMn5PUPE2mruN8Rli7QpsE?=
 =?us-ascii?Q?4hTeH8g+wmTot/+GJcqXsYjUajQNvXcbHx5v5fhnNnVRlpmj116ln8zwb0JL?=
 =?us-ascii?Q?7Uh8nJ3Qw4kokkmfok2L0nw6/w+QqOnKhVrfMdJP6v+MTScSIiv0IbG8ct7b?=
 =?us-ascii?Q?Rv9ZMDCg2St2b9drOe6m639xdHOoCZoSBkh4bdzrDOCt7/Nj2G2Dc8fBeNKV?=
 =?us-ascii?Q?MoqH5aMPkdYZqUxiKd3WnzuQlhg4tVfiQVH3sl30rborgt+U8FSvLBFjj+q1?=
 =?us-ascii?Q?FEqK5iqE3MRD4zxmt7+sI6PJqCngpjNUo47q2cVy+432WDGoQZgL?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a8159f-b303-4dd3-c287-08dede5d16f9
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:27:33.2758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NQWBS38DkjPB7iVdYdE2bE3lr5ofibE1wo1rvLRxQmmoTo5ZnewXs7Ja5AYu78uOPZYUM6DuS6bv23B58QgwlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7001
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-12307-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:arnd@arndb.de,m:dlemoal@kernel.org,m:cassel@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:linux-pci@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,valinux.co.jp:from_mime,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 05AB973895F

Add pci-epf-dma, an endpoint function that exposes selected
endpoint-integrated DMA channels as a separate PCI DMA controller
function.

The function consumes EPC auxiliary DMA channel and descriptor memory
resources, delegates channels through the EPC DMA channel delegation API,
publishes a stable metadata BAR for host discovery, and uses a DMA
window BAR for DMA resources that are not already host-visible. For
DesignWare eDMA unroll and HDMA compatible layouts, channel delegation
is constrained to whole directions. HDMA native linked-list mode uses
per-channel registers and can delegate a dense channel prefix without
taking the whole direction.

After the host-side driver finds the metadata and requests the final
layout, the endpoint function programs DMA window BAR submaps and marks
the metadata ready. If the link drops after the host request is set,
clear only the ready bit and retry submap programming on the next
link-up without requiring the host driver to probe again.

If setup fails before the metadata is marked ready, release any delegated
channels without asking the EPC backend to quiesce them. Once the ready
bit has been set, teardown requests quiesce because the host may have
programmed the exposed DMA windows.

The endpoint function does not bake in a vendor/device ID. As with other
generic endpoint functions, users provide the PCI IDs through the common
EPF configfs header attributes.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - Add support of IOMMU-backed EPCs scenario by DMA-mapping dynamic DMA
    control MMIO BAR submaps for the EPC parent while keeping descriptor
    DMA addresses unchanged.
  - Enrich source comments, add a dev_err and relocate dma_wmb() at a
    more suitable point.
  - Drop needless DMA_ENGINE select from Kconfig.

 drivers/pci/endpoint/functions/Kconfig       |   13 +
 drivers/pci/endpoint/functions/Makefile      |    1 +
 drivers/pci/endpoint/functions/pci-epf-dma.c | 1511 ++++++++++++++++++
 3 files changed, 1525 insertions(+)
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-dma.c

diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
index bb5a23994288..8783c82672cc 100644
--- a/drivers/pci/endpoint/functions/Kconfig
+++ b/drivers/pci/endpoint/functions/Kconfig
@@ -39,6 +39,19 @@ config PCI_EPF_VNTB
 
 	  If in doubt, say "N" to disable Endpoint NTB driver.
 
+config PCI_EPF_DMA
+	tristate "PCI Endpoint DMA driver"
+	depends on PCI_ENDPOINT
+	select CONFIGFS_FS
+	help
+	  Select this configuration option to expose an endpoint-integrated
+	  DMA controller as a PCI endpoint function. The function advertises
+	  the DMA controller layout to the host using BAR-resident metadata
+	  and maps resources that are not already host-visible into the
+	  DMA window BAR.
+
+	  If in doubt, say "N" to disable Endpoint DMA driver.
+
 config PCI_EPF_MHI
 	tristate "PCI Endpoint driver for MHI bus"
 	depends on PCI_ENDPOINT && MHI_BUS_EP
diff --git a/drivers/pci/endpoint/functions/Makefile b/drivers/pci/endpoint/functions/Makefile
index 696473fce50e..de92f6897b8f 100644
--- a/drivers/pci/endpoint/functions/Makefile
+++ b/drivers/pci/endpoint/functions/Makefile
@@ -6,4 +6,5 @@
 obj-$(CONFIG_PCI_EPF_TEST)		+= pci-epf-test.o
 obj-$(CONFIG_PCI_EPF_NTB)		+= pci-epf-ntb.o
 obj-$(CONFIG_PCI_EPF_VNTB) 		+= pci-epf-vntb.o
+obj-$(CONFIG_PCI_EPF_DMA)		+= pci-epf-dma.o
 obj-$(CONFIG_PCI_EPF_MHI)		+= pci-epf-mhi.o
diff --git a/drivers/pci/endpoint/functions/pci-epf-dma.c b/drivers/pci/endpoint/functions/pci-epf-dma.c
new file mode 100644
index 000000000000..2e57e3ce2020
--- /dev/null
+++ b/drivers/pci/endpoint/functions/pci-epf-dma.c
@@ -0,0 +1,1511 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI endpoint function that exposes an endpoint-integrated DMA controller
+ * to the PCI host.
+ *
+ * The host-side dw-edma-pcie driver consumes the BAR metadata published
+ * by this function.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/configfs.h>
+#include <linux/dma/edma.h>
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+#include <linux/overflow.h>
+#include <linux/pci-ep-dma.h>
+#include <linux/pci-epc.h>
+#include <linux/pci-epf.h>
+#include <linux/pci_regs.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+
+/* HOST_REQ is set by the host driver, so poll it at a low idle rate. */
+#define PCI_EPF_DMA_HOST_REQ_POLL_MS	500
+
+struct pci_epf_dma_bar_map {
+	const struct pci_epc_aux_resource *res;
+	enum pci_barno bar;
+	u64 res_offset_in_bar;
+	u64 submap_offset_in_bar;
+	dma_addr_t phys_addr;
+	dma_addr_t dma_addr;
+	size_t map_size;
+	bool needs_submap;
+	bool dma_mapped;
+};
+
+struct pci_epf_dma {
+	struct pci_epf *epf;
+	struct config_group group;
+	struct delayed_work map_work;
+
+	enum pci_barno metadata_bar;
+	enum pci_barno dma_window_bar;
+	u16 wr_chans;
+	u16 rd_chans;
+	u8 reg_layout;
+	u8 reg_layout_data;
+
+	/*
+	 * Backing storage for ctrl, channel and descriptor resource pointers.
+	 * DesignWare eDMA is the only exposed layout today, so EDMA_MAX_* is
+	 * the per-direction bound for these arrays.
+	 */
+	struct pci_epc_aux_resource *resources;
+	unsigned int num_resources;
+	const struct pci_epc_aux_resource *ctrl;
+	const struct pci_epc_aux_resource *ep_to_rc_aux_chan[EDMA_MAX_WR_CH];
+	const struct pci_epc_aux_resource *rc_to_ep_aux_chan[EDMA_MAX_RD_CH];
+	const struct pci_epc_aux_resource *ep_to_rc_desc[EDMA_MAX_WR_CH];
+	const struct pci_epc_aux_resource *rc_to_ep_desc[EDMA_MAX_RD_CH];
+
+	/* Local EPC reservations for channels delegated to the host. */
+	struct pci_epc_dma_chan *ep_to_rc_chan[EDMA_MAX_WR_CH];
+	struct pci_epc_dma_chan *rc_to_ep_chan[EDMA_MAX_RD_CH];
+
+	void *metadata_addr;
+	void *dma_window_addr;
+	size_t msix_table_offset;
+	struct pci_epf_dma_bar_map *bar_maps;
+	unsigned int num_bar_maps;
+	struct pci_epf_bar_submap *submaps;
+	unsigned int num_submaps;
+
+	/* Cleared when a later event should retry programming the submaps. */
+	bool submaps_programmed;
+	bool channels_exposed;
+};
+
+#define to_epf_dma(epf_group) container_of((epf_group), struct pci_epf_dma, group)
+
+static struct pci_epf_header pci_epf_dma_header = {
+	.vendorid	= PCI_ANY_ID,
+	.deviceid	= PCI_ANY_ID,
+	.baseclass_code	= PCI_BASE_CLASS_SYSTEM,
+	.subclass_code	= PCI_CLASS_SYSTEM_DMA & 0xff,
+	.interrupt_pin	= PCI_INTERRUPT_INTA,
+};
+
+static void pci_epf_dma_release_channels(struct pci_epf_dma *epf_dma)
+{
+	bool quiesce = epf_dma->channels_exposed;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(epf_dma->ep_to_rc_chan); i++) {
+		if (!epf_dma->ep_to_rc_chan[i])
+			continue;
+
+		pci_epc_reclaim_dma_chan(epf_dma->ep_to_rc_chan[i], quiesce);
+		epf_dma->ep_to_rc_chan[i] = NULL;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(epf_dma->rc_to_ep_chan); i++) {
+		if (!epf_dma->rc_to_ep_chan[i])
+			continue;
+
+		pci_epc_reclaim_dma_chan(epf_dma->rc_to_ep_chan[i], quiesce);
+		epf_dma->rc_to_ep_chan[i] = NULL;
+	}
+
+	epf_dma->channels_exposed = false;
+}
+
+static int pci_epf_dma_claim_channel(struct pci_epf_dma *epf_dma,
+				     const struct pci_epc_aux_resource *res,
+				     struct pci_epc_dma_chan **chan)
+{
+	struct pci_epf *epf = epf_dma->epf;
+	struct device *dev = &epf_dma->epf->dev;
+	int ret;
+
+	ret = pci_epc_delegate_dma_chan(epf->epc, epf->func_no, epf->vfunc_no,
+					res->u.dma_chan.dir,
+					res->u.dma_chan.hw_ch, chan);
+	if (ret) {
+		dev_err(dev, "DMA channel %u cannot be delegated\n",
+			res->u.dma_chan.hw_ch);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int
+pci_epf_dma_validate_dw_edma_ctrl(struct pci_epf_dma *epf_dma,
+				  const struct pci_epc_aux_resource *ctrl)
+{
+	struct device *dev = &epf_dma->epf->dev;
+	enum dw_edma_map_format map = ctrl->u.dma_ctrl.reg_layout_data;
+	u16 total_wr_chans = ctrl->u.dma_ctrl.ep_to_rc_ch_cnt;
+	u16 total_rd_chans = ctrl->u.dma_ctrl.rc_to_ep_ch_cnt;
+
+	switch (map) {
+	case EDMA_MF_EDMA_LEGACY:
+		dev_err(dev, "legacy DesignWare eDMA layout cannot be delegated\n");
+		return -EOPNOTSUPP;
+	case EDMA_MF_EDMA_UNROLL:
+	case EDMA_MF_HDMA_COMPAT:
+		/*
+		 * DesignWare eDMA v0 layouts share control across each
+		 * direction, so do not split one direction between the endpoint
+		 * and the host.
+		 */
+		if ((epf_dma->wr_chans && epf_dma->wr_chans != total_wr_chans) ||
+		    (epf_dma->rd_chans && epf_dma->rd_chans != total_rd_chans)) {
+			dev_err(dev, "DesignWare eDMA v0 delegation must cover the whole direction\n");
+			return -EOPNOTSUPP;
+		}
+		return 0;
+	case EDMA_MF_HDMA_NATIVE:
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static bool pci_epf_dma_bar_usable(const struct pci_epc_features *epc_features,
+				   enum pci_barno bar)
+{
+	if (bar < BAR_0 || bar >= PCI_STD_NUM_BARS)
+		return false;
+
+	return epc_features->bar[bar].type != BAR_RESERVED &&
+	       epc_features->bar[bar].type != BAR_DISABLED;
+}
+
+static bool pci_epf_dma_bar_has_fixed_resource(struct pci_epf_dma *epf_dma,
+					       enum pci_barno bar)
+{
+	unsigned int i;
+
+	for (i = 0; i < epf_dma->num_resources; i++) {
+		if (epf_dma->resources[i].bar == bar)
+			return true;
+	}
+
+	return false;
+}
+
+static enum pci_barno
+pci_epf_dma_first_usable_bar(struct pci_epf_dma *epf_dma,
+			     const struct pci_epc_features *epc_features,
+			     enum pci_barno exclude)
+{
+	enum pci_barno bar;
+
+	for (bar = BAR_0; bar < PCI_STD_NUM_BARS; bar++) {
+		bar = pci_epc_get_next_free_bar(epc_features, bar);
+		if (bar == NO_BAR)
+			return NO_BAR;
+		if (bar != exclude &&
+		    !pci_epf_dma_bar_has_fixed_resource(epf_dma, bar))
+			return bar;
+	}
+
+	return NO_BAR;
+}
+
+static size_t pci_epf_dma_align_size(size_t size, size_t align)
+{
+	if (!align)
+		return size;
+
+	return ALIGN(size, align);
+}
+
+static int pci_epf_dma_reuse_submap(struct pci_epf_dma *epf_dma,
+				    unsigned int map_count,
+				    dma_addr_t phys_addr, size_t map_size,
+				    size_t offset, size_t *next_offset_in_bar,
+				    u64 *res_offset_in_bar)
+{
+	struct pci_epf_dma_bar_map *map;
+	u64 delta;
+	size_t merged_size, next;
+	u64 res_map_end, submap_bar_end, submap_phys_end;
+	unsigned int i;
+
+	if (check_add_overflow(phys_addr, map_size, &res_map_end))
+		return -EOVERFLOW;
+
+	for (i = 0; i < map_count; i++) {
+		map = &epf_dma->bar_maps[i];
+		if (!map->needs_submap || map->bar != epf_dma->dma_window_bar)
+			continue;
+
+		if (check_add_overflow(map->phys_addr, map->map_size,
+				       &submap_phys_end) ||
+		    check_add_overflow(map->submap_offset_in_bar,
+				       map->map_size, &submap_bar_end))
+			return -EOVERFLOW;
+
+		/*
+		 * Reuse a submap that already covers this aligned resource
+		 * window.
+		 */
+		if (phys_addr >= map->phys_addr &&
+		    res_map_end <= submap_phys_end) {
+			if (check_add_overflow(phys_addr - map->phys_addr,
+					       offset, &delta) ||
+			    check_add_overflow(map->submap_offset_in_bar,
+					       delta, res_offset_in_bar))
+				return -EOVERFLOW;
+			return 1;
+		}
+
+		/*
+		 * Extend only the BAR-tail submap when the physical ranges are
+		 * contiguous.
+		 */
+		if (submap_phys_end == phys_addr &&
+		    submap_bar_end == *next_offset_in_bar) {
+			if (check_add_overflow(map->map_size, map_size,
+					       &merged_size) ||
+			    check_add_overflow(*next_offset_in_bar, map_size,
+					       &next) ||
+			    check_add_overflow(*next_offset_in_bar, offset,
+					       res_offset_in_bar))
+				return -EOVERFLOW;
+
+			map->map_size = merged_size;
+			*next_offset_in_bar = next;
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+static int pci_epf_dma_add_map(struct pci_epf_dma *epf_dma,
+			       const struct pci_epc_aux_resource *res,
+			       size_t align, size_t *next_offset_in_bar,
+			       unsigned int *map_idx)
+{
+	dma_addr_t phys_addr;
+	size_t map_size, offset = 0, next;
+	u64 res_offset_in_bar;
+	unsigned int i;
+	int ret;
+
+	if (!res || !res->size)
+		return -EINVAL;
+
+	for (i = 0; i < *map_idx; i++) {
+		if (epf_dma->bar_maps[i].res == res)
+			return 0;
+	}
+
+	if (res->bar != NO_BAR) {
+		if (res->bar < BAR_0 || res->bar >= PCI_STD_NUM_BARS)
+			return -EINVAL;
+		if (res->bar == epf_dma->metadata_bar ||
+		    res->bar == epf_dma->dma_window_bar)
+			return -EINVAL;
+
+		epf_dma->bar_maps[*map_idx] = (struct pci_epf_dma_bar_map) {
+			.res = res,
+			.bar = res->bar,
+			.res_offset_in_bar = res->bar_offset,
+			.map_size = res->size,
+		};
+		(*map_idx)++;
+
+		return 0;
+	}
+
+	if (epf_dma->dma_window_bar == NO_BAR)
+		return -EOPNOTSUPP;
+
+	phys_addr = res->phys_addr;
+	/* Map the aligned window that contains this resource. */
+	if (align) {
+		phys_addr = ALIGN_DOWN(res->phys_addr, align);
+		offset = res->phys_addr - phys_addr;
+	}
+
+	if (check_add_overflow(res->size, offset, &map_size))
+		return -EOVERFLOW;
+	map_size = pci_epf_dma_align_size(map_size, align);
+
+	ret = pci_epf_dma_reuse_submap(epf_dma, *map_idx, phys_addr, map_size,
+				       offset, next_offset_in_bar,
+				       &res_offset_in_bar);
+	if (ret < 0)
+		return ret;
+	if (ret) {
+		epf_dma->bar_maps[*map_idx] = (struct pci_epf_dma_bar_map) {
+			.res = res,
+			.bar = epf_dma->dma_window_bar,
+			.res_offset_in_bar = res_offset_in_bar,
+			.phys_addr = res->phys_addr,
+			.map_size = res->size,
+		};
+
+		(*map_idx)++;
+
+		return 0;
+	}
+
+	if (check_add_overflow(*next_offset_in_bar, map_size, &next))
+		return -EOVERFLOW;
+	if (check_add_overflow(*next_offset_in_bar, offset, &res_offset_in_bar))
+		return -EOVERFLOW;
+
+	epf_dma->bar_maps[*map_idx] = (struct pci_epf_dma_bar_map) {
+		.res = res,
+		.bar = epf_dma->dma_window_bar,
+		.res_offset_in_bar = res_offset_in_bar,
+		.submap_offset_in_bar = *next_offset_in_bar,
+		.phys_addr = phys_addr,
+		.map_size = map_size,
+		.needs_submap = true,
+	};
+
+	*next_offset_in_bar = next;
+	(*map_idx)++;
+
+	return 0;
+}
+
+static void pci_epf_dma_unmap_submaps(struct pci_epf_dma *epf_dma)
+{
+	struct pci_epc *epc = epf_dma->epf->epc;
+	struct device *dev;
+	unsigned int i;
+
+	if (!epc)
+		return;
+
+	dev = epc->dev.parent;
+
+	for (i = 0; i < epf_dma->num_bar_maps; i++) {
+		struct pci_epf_dma_bar_map *map = &epf_dma->bar_maps[i];
+
+		if (!map->dma_mapped)
+			continue;
+
+		dma_unmap_resource(dev, map->dma_addr, map->map_size,
+				   DMA_BIDIRECTIONAL, 0);
+		map->dma_mapped = false;
+	}
+}
+
+static int pci_epf_dma_map_submaps(struct pci_epf_dma *epf_dma)
+{
+	struct pci_epc *epc = epf_dma->epf->epc;
+	struct device *dev = epc->dev.parent;
+	unsigned int i;
+
+	for (i = 0; i < epf_dma->num_bar_maps; i++) {
+		struct pci_epf_dma_bar_map *map = &epf_dma->bar_maps[i];
+
+		if (!map->needs_submap)
+			continue;
+
+		/*
+		 * Descriptor resources carry endpoint-local DMA addresses.
+		 * Controller MMIO resources are CPU physical addresses, so map
+		 * them for the EPC parent before programming inbound windows.
+		 */
+		if (map->res->type != PCI_EPC_AUX_DMA_CTRL_MMIO)
+			continue;
+
+		map->dma_addr = dma_map_resource(dev, map->phys_addr,
+						 map->map_size,
+						 DMA_BIDIRECTIONAL, 0);
+		if (dma_mapping_error(dev, map->dma_addr)) {
+			pci_epf_dma_unmap_submaps(epf_dma);
+			return -EIO;
+		}
+
+		map->dma_mapped = true;
+	}
+
+	return 0;
+}
+
+static dma_addr_t pci_epf_dma_submap_addr(const struct pci_epf_dma_bar_map *map)
+{
+	if (map->dma_mapped)
+		return map->dma_addr;
+
+	return map->phys_addr;
+}
+
+static const struct pci_epf_dma_bar_map *
+pci_epf_dma_find_map(struct pci_epf_dma *epf_dma,
+		     const struct pci_epc_aux_resource *res)
+{
+	unsigned int i;
+
+	for (i = 0; i < epf_dma->num_bar_maps; i++) {
+		if (epf_dma->bar_maps[i].res == res)
+			return &epf_dma->bar_maps[i];
+	}
+
+	return NULL;
+}
+
+static bool pci_epf_dma_needs_dma_window(struct pci_epf_dma *epf_dma)
+{
+	unsigned int i;
+
+	if (epf_dma->ctrl && epf_dma->ctrl->bar == NO_BAR)
+		return true;
+
+	for (i = 0; i < epf_dma->wr_chans; i++) {
+		if (epf_dma->ep_to_rc_desc[i] &&
+		    epf_dma->ep_to_rc_desc[i]->bar == NO_BAR)
+			return true;
+	}
+
+	for (i = 0; i < epf_dma->rd_chans; i++) {
+		if (epf_dma->rc_to_ep_desc[i] &&
+		    epf_dma->rc_to_ep_desc[i]->bar == NO_BAR)
+			return true;
+	}
+
+	return false;
+}
+
+static const struct pci_epc_aux_resource *
+pci_epf_dma_find_desc_mem(const struct pci_epc_aux_resource *res, int count,
+			  u16 id)
+{
+	int i;
+
+	for (i = 0; i < count; i++) {
+		if (res[i].type == PCI_EPC_AUX_DMA_DESC_MEM &&
+		    res[i].u.dma_desc.id == id)
+			return &res[i];
+	}
+
+	return NULL;
+}
+
+static int pci_epf_dma_collect_resources(struct pci_epf_dma *epf_dma)
+{
+	const struct pci_epc_aux_resource *ep_to_rc_aux_chan[EDMA_MAX_WR_CH] = {};
+	const struct pci_epc_aux_resource *rc_to_ep_aux_chan[EDMA_MAX_RD_CH] = {};
+	const struct pci_epc_aux_resource *ep_to_rc_desc[EDMA_MAX_WR_CH] = {};
+	const struct pci_epc_aux_resource *rc_to_ep_desc[EDMA_MAX_RD_CH] = {};
+	const struct pci_epc_aux_resource *ctrl = NULL;
+	struct pci_epf *epf = epf_dma->epf;
+	struct pci_epc *epc = epf->epc;
+	struct device *dev = &epf->dev;
+	int count, i, ret;
+
+	count = pci_epc_get_aux_resources_count(epc, epf->func_no,
+						epf->vfunc_no);
+	if (count <= 0)
+		return count ?: -ENODEV;
+
+	struct pci_epc_aux_resource *res __free(kfree) =
+						kzalloc_objs(*res, count);
+	if (!res)
+		return -ENOMEM;
+
+	ret = pci_epc_get_aux_resources(epc, epf->func_no, epf->vfunc_no,
+					res, count);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < count; i++) {
+		switch (res[i].type) {
+		case PCI_EPC_AUX_DMA_CTRL_MMIO:
+			if (ctrl)
+				return -EINVAL;
+			ctrl = &res[i];
+			break;
+		case PCI_EPC_AUX_DMA_CHAN: {
+			u16 hw_ch = res[i].u.dma_chan.hw_ch;
+
+			switch (res[i].u.dma_chan.dir) {
+			case PCI_EPC_AUX_DMA_EP_TO_RC:
+				if (hw_ch >= EDMA_MAX_WR_CH ||
+				    ep_to_rc_aux_chan[hw_ch])
+					return -EINVAL;
+				ep_to_rc_aux_chan[hw_ch] = &res[i];
+				break;
+			case PCI_EPC_AUX_DMA_RC_TO_EP:
+				if (hw_ch >= EDMA_MAX_RD_CH ||
+				    rc_to_ep_aux_chan[hw_ch])
+					return -EINVAL;
+				rc_to_ep_aux_chan[hw_ch] = &res[i];
+				break;
+			default:
+				return -EINVAL;
+			}
+			break;
+		}
+		case PCI_EPC_AUX_DMA_DESC_MEM:
+			if (pci_epf_dma_find_desc_mem(res, i,
+						      res[i].u.dma_desc.id))
+				return -EINVAL;
+			break;
+		default:
+			continue;
+		}
+	}
+
+	if (!ctrl)
+		return -ENODEV;
+
+	if (!epf_dma->wr_chans && !epf_dma->rd_chans) {
+		dev_err(dev, "no DMA channels requested\n");
+		return -EINVAL;
+	}
+
+	if (epf_dma->wr_chans > ctrl->u.dma_ctrl.ep_to_rc_ch_cnt ||
+	    epf_dma->rd_chans > ctrl->u.dma_ctrl.rc_to_ep_ch_cnt)
+		return -EINVAL;
+
+	switch (ctrl->u.dma_ctrl.reg_layout) {
+	case PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA:
+		ret = pci_epf_dma_validate_dw_edma_ctrl(epf_dma, ctrl);
+		if (ret)
+			return ret;
+		epf_dma->reg_layout = PCI_EP_DMA_METADATA_REG_LAYOUT_DW_EDMA;
+		epf_dma->reg_layout_data = ctrl->u.dma_ctrl.reg_layout_data;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	for (i = 0; i < epf_dma->wr_chans; i++) {
+		if (!ep_to_rc_aux_chan[i]) {
+			dev_err(dev, "missing dense write DMA channel %d\n", i);
+			return -EINVAL;
+		}
+	}
+
+	for (i = 0; i < epf_dma->rd_chans; i++) {
+		if (!rc_to_ep_aux_chan[i]) {
+			dev_err(dev, "missing dense read DMA channel %d\n", i);
+			return -EINVAL;
+		}
+	}
+
+	for (i = 0; i < epf_dma->wr_chans; i++) {
+		u16 desc_mem_id = ep_to_rc_aux_chan[i]->u.dma_chan.desc_mem_id;
+
+		ep_to_rc_desc[i] = pci_epf_dma_find_desc_mem(res, count, desc_mem_id);
+		if (!ep_to_rc_desc[i]) {
+			dev_err(dev, "missing write DMA descriptor memory %d\n", i);
+			return -EINVAL;
+		}
+	}
+
+	for (i = 0; i < epf_dma->rd_chans; i++) {
+		u16 desc_mem_id = rc_to_ep_aux_chan[i]->u.dma_chan.desc_mem_id;
+
+		rc_to_ep_desc[i] = pci_epf_dma_find_desc_mem(res, count, desc_mem_id);
+		if (!rc_to_ep_desc[i]) {
+			dev_err(dev, "missing read DMA descriptor memory %d\n", i);
+			return -EINVAL;
+		}
+	}
+
+	for (i = 0; i < epf_dma->wr_chans; i++) {
+		ret = pci_epf_dma_claim_channel(epf_dma, ep_to_rc_aux_chan[i],
+						&epf_dma->ep_to_rc_chan[i]);
+		if (ret)
+			goto err_release_channels;
+	}
+
+	for (i = 0; i < epf_dma->rd_chans; i++) {
+		ret = pci_epf_dma_claim_channel(epf_dma, rc_to_ep_aux_chan[i],
+						&epf_dma->rc_to_ep_chan[i]);
+		if (ret)
+			goto err_release_channels;
+	}
+
+	epf_dma->resources = no_free_ptr(res);
+	epf_dma->num_resources = count;
+	epf_dma->ctrl = ctrl;
+	memcpy(epf_dma->ep_to_rc_aux_chan, ep_to_rc_aux_chan,
+	       sizeof(ep_to_rc_aux_chan));
+	memcpy(epf_dma->rc_to_ep_aux_chan, rc_to_ep_aux_chan,
+	       sizeof(rc_to_ep_aux_chan));
+	memcpy(epf_dma->ep_to_rc_desc, ep_to_rc_desc, sizeof(ep_to_rc_desc));
+	memcpy(epf_dma->rc_to_ep_desc, rc_to_ep_desc, sizeof(rc_to_ep_desc));
+
+	return 0;
+
+err_release_channels:
+	pci_epf_dma_release_channels(epf_dma);
+
+	return ret;
+}
+
+static void pci_epf_dma_metadata_write(__le32 *metadata, u16 metadata_off,
+				       u32 val)
+{
+	metadata[metadata_off / sizeof(*metadata)] = cpu_to_le32(val);
+}
+
+static void pci_epf_dma_metadata_write64(__le32 *metadata, u16 metadata_off,
+					 u64 val)
+{
+	pci_epf_dma_metadata_write(metadata, metadata_off, lower_32_bits(val));
+	pci_epf_dma_metadata_write(metadata, metadata_off + sizeof(u32),
+				   upper_32_bits(val));
+}
+
+static int pci_epf_dma_build_ch_entry(const struct pci_epc_aux_resource *chan,
+				      const struct pci_epf_dma_bar_map *map,
+				      __le32 *metadata, u16 entry)
+{
+	const struct pci_epc_aux_resource *res = map->res;
+	u32 ctrl;
+
+	if (res->size > U32_MAX)
+		return -EOVERFLOW;
+
+	ctrl = FIELD_PREP(PCI_EP_DMA_METADATA_CH_CTRL_HW_CH,
+			  chan->u.dma_chan.hw_ch) |
+	       FIELD_PREP(PCI_EP_DMA_METADATA_CH_CTRL_DESC_BAR, map->bar);
+
+	pci_epf_dma_metadata_write(metadata, entry + PCI_EP_DMA_METADATA_CH_CTRL,
+				   ctrl);
+	pci_epf_dma_metadata_write64(metadata,
+				     entry + PCI_EP_DMA_METADATA_CH_DESC_OFF_LO,
+				     map->res_offset_in_bar);
+	pci_epf_dma_metadata_write(metadata,
+				   entry + PCI_EP_DMA_METADATA_CH_DESC_SIZE,
+				   (u32)res->size);
+	pci_epf_dma_metadata_write64(metadata,
+				     entry + PCI_EP_DMA_METADATA_CH_DESC_ADDR_LO,
+				     res->phys_addr);
+
+	return 0;
+}
+
+static void pci_epf_dma_set_metadata_ready(struct pci_epf_dma *epf_dma,
+					   bool ready)
+{
+	__le32 *metadata = epf_dma->metadata_addr;
+	__le32 *ctrl_ptr;
+	u32 ctrl;
+
+	if (!metadata)
+		return;
+
+	ctrl_ptr = &metadata[PCI_EP_DMA_METADATA_CTRL / sizeof(*metadata)];
+	ctrl = le32_to_cpu(READ_ONCE(*ctrl_ptr));
+	if (ready)
+		ctrl |= PCI_EP_DMA_METADATA_CTRL_READY;
+	else
+		ctrl &= ~PCI_EP_DMA_METADATA_CTRL_READY;
+	if (ready)
+		dma_wmb();
+	WRITE_ONCE(*ctrl_ptr, cpu_to_le32(ctrl));
+	if (ready)
+		epf_dma->channels_exposed = true;
+}
+
+static bool pci_epf_dma_metadata_host_requested(struct pci_epf_dma *epf_dma)
+{
+	__le32 *metadata = epf_dma->metadata_addr;
+	u32 ctrl;
+
+	if (!metadata)
+		return false;
+
+	ctrl = le32_to_cpu(READ_ONCE(metadata[PCI_EP_DMA_METADATA_CTRL /
+					    sizeof(*metadata)]));
+
+	return ctrl & PCI_EP_DMA_METADATA_CTRL_HOST_REQ;
+}
+
+static void pci_epf_dma_clear_metadata_status(struct pci_epf_dma *epf_dma)
+{
+	__le32 *metadata = epf_dma->metadata_addr;
+	__le32 *ctrl_ptr;
+	u32 ctrl;
+
+	if (!metadata)
+		return;
+
+	ctrl_ptr = &metadata[PCI_EP_DMA_METADATA_CTRL / sizeof(*metadata)];
+	ctrl = le32_to_cpu(READ_ONCE(*ctrl_ptr));
+	ctrl &= ~(PCI_EP_DMA_METADATA_CTRL_HOST_REQ |
+		  PCI_EP_DMA_METADATA_CTRL_READY);
+	WRITE_ONCE(*ctrl_ptr, cpu_to_le32(ctrl));
+}
+
+static int pci_epf_dma_build_metadata(struct pci_epf_dma *epf_dma)
+{
+	const struct pci_epf_dma_bar_map *ctrl_map;
+	u16 entry_size = PCI_EP_DMA_METADATA_CH_ENTRY_SIZE;
+	u16 wr_table, rd_table, total_len;
+	__le32 *metadata = epf_dma->metadata_addr;
+	unsigned int i;
+	int ret;
+
+	if (!metadata)
+		return -EINVAL;
+
+	ctrl_map = pci_epf_dma_find_map(epf_dma, epf_dma->ctrl);
+	if (!ctrl_map)
+		return -EINVAL;
+	if (epf_dma->wr_chans > FIELD_MAX(PCI_EP_DMA_METADATA_CTRL_WR_CH_COUNT) ||
+	    epf_dma->rd_chans > FIELD_MAX(PCI_EP_DMA_METADATA_CTRL_RD_CH_COUNT) ||
+	    entry_size > FIELD_MAX(PCI_EP_DMA_METADATA_CTRL_CH_ENTRY_SIZE) ||
+	    ctrl_map->res->size > U32_MAX)
+		return -EOVERFLOW;
+
+	wr_table = epf_dma->wr_chans ? PCI_EP_DMA_METADATA_HDR_LEN : 0;
+	rd_table = epf_dma->rd_chans ?
+		   PCI_EP_DMA_METADATA_HDR_LEN + epf_dma->wr_chans * entry_size : 0;
+	total_len = PCI_EP_DMA_METADATA_HDR_LEN +
+		    (epf_dma->wr_chans + epf_dma->rd_chans) * entry_size;
+
+	memset(metadata, 0, total_len);
+
+	pci_epf_dma_metadata_write(metadata, 0, PCI_EP_DMA_METADATA_MAGIC);
+	pci_epf_dma_metadata_write(metadata, PCI_EP_DMA_METADATA_HDR,
+				   FIELD_PREP(PCI_EP_DMA_METADATA_HDR_REV,
+					      PCI_EP_DMA_METADATA_REV) |
+				   FIELD_PREP(PCI_EP_DMA_METADATA_HDR_LEN_FIELD,
+					      total_len));
+	pci_epf_dma_metadata_write(metadata, PCI_EP_DMA_METADATA_CTRL,
+				   FIELD_PREP(PCI_EP_DMA_METADATA_CTRL_REG_BAR,
+					      ctrl_map->bar) |
+				   FIELD_PREP(PCI_EP_DMA_METADATA_CTRL_WR_CH_COUNT,
+					      epf_dma->wr_chans) |
+				   FIELD_PREP(PCI_EP_DMA_METADATA_CTRL_RD_CH_COUNT,
+					      epf_dma->rd_chans) |
+				   FIELD_PREP(PCI_EP_DMA_METADATA_CTRL_CH_ENTRY_SIZE,
+					      entry_size));
+	pci_epf_dma_metadata_write64(metadata,
+				     PCI_EP_DMA_METADATA_REG_OFF_LO,
+				     ctrl_map->res_offset_in_bar);
+	pci_epf_dma_metadata_write(metadata, PCI_EP_DMA_METADATA_REG_LAYOUT,
+				   FIELD_PREP(PCI_EP_DMA_METADATA_REG_LAYOUT_ID,
+					      epf_dma->reg_layout) |
+				   FIELD_PREP(PCI_EP_DMA_METADATA_REG_LAYOUT_DATA,
+					      epf_dma->reg_layout_data));
+	pci_epf_dma_metadata_write(metadata, PCI_EP_DMA_METADATA_REG_SIZE,
+				   (u32)ctrl_map->res->size);
+
+	for (i = 0; i < epf_dma->wr_chans; i++) {
+		const struct pci_epf_dma_bar_map *map;
+
+		map = pci_epf_dma_find_map(epf_dma,
+					   epf_dma->ep_to_rc_desc[i]);
+		if (!map)
+			return -EINVAL;
+		ret = pci_epf_dma_build_ch_entry(epf_dma->ep_to_rc_aux_chan[i],
+						 map, metadata,
+						 wr_table + i * entry_size);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < epf_dma->rd_chans; i++) {
+		const struct pci_epf_dma_bar_map *map;
+
+		map = pci_epf_dma_find_map(epf_dma,
+					   epf_dma->rc_to_ep_desc[i]);
+		if (!map)
+			return -EINVAL;
+		ret = pci_epf_dma_build_ch_entry(epf_dma->rc_to_ep_aux_chan[i],
+						 map, metadata,
+						 rd_table + i * entry_size);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int pci_epf_dma_reserve_msix(struct pci_epf_dma *epf_dma,
+				    const struct pci_epc_features *epc_features,
+				    size_t *backing_size)
+{
+	struct pci_epf *epf = epf_dma->epf;
+	size_t msix_table_size, pba_size, next;
+	unsigned int nvec = epf->msix_interrupts;
+
+	epf_dma->msix_table_offset = 0;
+
+	if (!epc_features->msix_capable || !nvec)
+		return 0;
+
+	next = ALIGN(*backing_size, 8);
+	if (next > U32_MAX)
+		return -EOVERFLOW;
+	epf_dma->msix_table_offset = next;
+
+	if (check_mul_overflow(PCI_MSIX_ENTRY_SIZE, nvec, &msix_table_size))
+		return -EOVERFLOW;
+
+	pba_size = ALIGN(DIV_ROUND_UP(nvec, 8), 8);
+	if (check_add_overflow(next, msix_table_size, &next) ||
+	    next > U32_MAX ||
+	    check_add_overflow(next, pba_size, &next))
+		return -EOVERFLOW;
+
+	*backing_size = next;
+
+	return 0;
+}
+
+static int pci_epf_dma_build_layout(struct pci_epf_dma *epf_dma,
+				    const struct pci_epc_features *epc_features)
+{
+	struct pci_epf *epf = epf_dma->epf;
+	struct device *dev = &epf->dev;
+	struct pci_epf_bar *bar;
+	unsigned int max_maps, map_idx = 0, sub_idx = 0;
+	size_t align = epc_features->align;
+	size_t metadata_size, metadata_backing_size, metadata_bar_size;
+	size_t mapped_size = 0, dma_window_bar_size;
+	int i, ret;
+
+	metadata_size = PCI_EP_DMA_METADATA_HDR_LEN;
+	metadata_size += (epf_dma->wr_chans + epf_dma->rd_chans) *
+			 PCI_EP_DMA_METADATA_CH_ENTRY_SIZE;
+	metadata_backing_size = metadata_size;
+	ret = pci_epf_dma_reserve_msix(epf_dma, epc_features,
+				       &metadata_backing_size);
+	if (ret)
+		return ret;
+	metadata_bar_size = pci_epf_dma_align_size(metadata_backing_size,
+						   align);
+
+	epf_dma->metadata_addr = pci_epf_alloc_space(epf, metadata_bar_size,
+						     epf_dma->metadata_bar,
+						     epc_features,
+						     PRIMARY_INTERFACE);
+	if (!epf_dma->metadata_addr) {
+		dev_err(dev, "failed to allocate BAR%d metadata space\n",
+			epf_dma->metadata_bar);
+		return -ENOMEM;
+	}
+	memset(epf_dma->metadata_addr, 0, epf->bar[epf_dma->metadata_bar].size);
+
+	/* One map for DMA controller registers, plus one per channel. */
+	max_maps = 1 + epf_dma->wr_chans + epf_dma->rd_chans;
+	epf_dma->bar_maps = kzalloc_objs(*epf_dma->bar_maps, max_maps);
+	if (!epf_dma->bar_maps)
+		return -ENOMEM;
+
+	ret = pci_epf_dma_add_map(epf_dma, epf_dma->ctrl, align,
+				  &mapped_size, &map_idx);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < epf_dma->wr_chans; i++) {
+		ret = pci_epf_dma_add_map(epf_dma,
+					  epf_dma->ep_to_rc_desc[i], align,
+					  &mapped_size, &map_idx);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < epf_dma->rd_chans; i++) {
+		ret = pci_epf_dma_add_map(epf_dma,
+					  epf_dma->rc_to_ep_desc[i], align,
+					  &mapped_size, &map_idx);
+		if (ret)
+			return ret;
+	}
+
+	epf_dma->num_bar_maps = map_idx;
+
+	ret = pci_epf_dma_build_metadata(epf_dma);
+	if (ret)
+		return ret;
+
+	/* Some DMA resources may already be visible through another map. */
+	for (i = 0; i < epf_dma->num_bar_maps; i++) {
+		if (epf_dma->bar_maps[i].needs_submap)
+			epf_dma->num_submaps++;
+	}
+	if (!epf_dma->num_submaps)
+		return 0;
+
+	ret = pci_epf_dma_map_submaps(epf_dma);
+	if (ret)
+		return ret;
+
+	dma_window_bar_size = mapped_size;
+	epf_dma->dma_window_addr =
+		pci_epf_alloc_space(epf, dma_window_bar_size,
+				    epf_dma->dma_window_bar, epc_features,
+				    PRIMARY_INTERFACE);
+	if (!epf_dma->dma_window_addr) {
+		dev_err(dev, "failed to allocate BAR%d DMA window space\n",
+			epf_dma->dma_window_bar);
+		return -ENOMEM;
+	}
+	bar = &epf->bar[epf_dma->dma_window_bar];
+	memset(epf_dma->dma_window_addr, 0, bar->size);
+
+	if (bar->size > mapped_size)
+		epf_dma->num_submaps++;
+
+	epf_dma->submaps = kzalloc_objs(*epf_dma->submaps, epf_dma->num_submaps);
+	if (!epf_dma->submaps)
+		return -ENOMEM;
+
+	for (i = 0; i < epf_dma->num_bar_maps; i++) {
+		struct pci_epf_dma_bar_map *map = &epf_dma->bar_maps[i];
+
+		if (!map->needs_submap)
+			continue;
+
+		epf_dma->submaps[sub_idx++] = (struct pci_epf_bar_submap) {
+			.phys_addr = pci_epf_dma_submap_addr(map),
+			.size = map->map_size,
+		};
+	}
+
+	/* Cover any BAR tail padding with the allocated scratch space. */
+	if (bar->size > mapped_size) {
+		epf_dma->submaps[sub_idx++] = (struct pci_epf_bar_submap) {
+			.phys_addr = bar->phys_addr + mapped_size,
+			.size = bar->size - mapped_size,
+		};
+	}
+
+	return 0;
+}
+
+static void pci_epf_dma_free_layout(struct pci_epf_dma *epf_dma)
+{
+	struct pci_epf *epf = epf_dma->epf;
+	struct pci_epf_bar *bar;
+
+	if (epf_dma->dma_window_addr) {
+		bar = &epf->bar[epf_dma->dma_window_bar];
+		bar->submap = NULL;
+		bar->num_submap = 0;
+	}
+	epf_dma->submaps_programmed = false;
+
+	kfree(epf_dma->submaps);
+	epf_dma->submaps = NULL;
+	epf_dma->num_submaps = 0;
+
+	pci_epf_dma_unmap_submaps(epf_dma);
+
+	kfree(epf_dma->bar_maps);
+	epf_dma->bar_maps = NULL;
+	epf_dma->num_bar_maps = 0;
+
+	pci_epf_dma_release_channels(epf_dma);
+
+	kfree(epf_dma->resources);
+	epf_dma->resources = NULL;
+	epf_dma->num_resources = 0;
+	epf_dma->ctrl = NULL;
+	memset(epf_dma->ep_to_rc_aux_chan, 0, sizeof(epf_dma->ep_to_rc_aux_chan));
+	memset(epf_dma->rc_to_ep_aux_chan, 0, sizeof(epf_dma->rc_to_ep_aux_chan));
+	memset(epf_dma->ep_to_rc_desc, 0, sizeof(epf_dma->ep_to_rc_desc));
+	memset(epf_dma->rc_to_ep_desc, 0, sizeof(epf_dma->rc_to_ep_desc));
+
+	if (epf_dma->dma_window_addr) {
+		pci_epf_free_space(epf, epf_dma->dma_window_addr,
+				   epf_dma->dma_window_bar,
+				   PRIMARY_INTERFACE);
+		epf_dma->dma_window_addr = NULL;
+	}
+
+	if (epf_dma->metadata_addr) {
+		pci_epf_free_space(epf, epf_dma->metadata_addr,
+				   epf_dma->metadata_bar,
+				   PRIMARY_INTERFACE);
+		epf_dma->metadata_addr = NULL;
+	}
+	epf_dma->msix_table_offset = 0;
+}
+
+static int pci_epf_dma_program_submaps(struct pci_epf_dma *epf_dma)
+{
+	struct pci_epf *epf = epf_dma->epf;
+	struct pci_epf_bar *bar;
+	int ret;
+
+	if (!epf_dma->dma_window_addr) {
+		pci_epf_dma_set_metadata_ready(epf_dma, true);
+		return 0;
+	}
+
+	if (epf_dma->submaps_programmed)
+		return 0;
+
+	bar = &epf->bar[epf_dma->dma_window_bar];
+	bar->submap = epf_dma->submaps;
+	bar->num_submap = epf_dma->num_submaps;
+
+	ret = pci_epc_set_bar(epf->epc, epf->func_no, epf->vfunc_no, bar);
+	if (ret) {
+		bar->submap = NULL;
+		bar->num_submap = 0;
+		return ret;
+	}
+
+	epf_dma->submaps_programmed = true;
+	pci_epf_dma_set_metadata_ready(epf_dma, true);
+
+	return 0;
+}
+
+static void pci_epf_dma_map_work(struct work_struct *work)
+{
+	struct pci_epf_dma *epf_dma =
+		container_of(to_delayed_work(work), struct pci_epf_dma,
+			     map_work);
+	struct pci_epf *epf = epf_dma->epf;
+	int ret;
+
+	if (!epf->epc)
+		return;
+
+	if (!epf->epc->init_complete) {
+		schedule_delayed_work(&epf_dma->map_work,
+				      msecs_to_jiffies(PCI_EPF_DMA_HOST_REQ_POLL_MS));
+		return;
+	}
+
+	if (!pci_epf_dma_metadata_host_requested(epf_dma)) {
+		schedule_delayed_work(&epf_dma->map_work,
+				      msecs_to_jiffies(PCI_EPF_DMA_HOST_REQ_POLL_MS));
+		return;
+	}
+
+	ret = pci_epf_dma_program_submaps(epf_dma);
+	if (ret) {
+		/*
+		 * Do not retry a failed submap update. It usually means the BAR
+		 * assignment or EPC/iATU state is unusable for this host request.
+		 */
+		dev_err(&epf->dev, "failed to program DMA window BAR submaps: %d\n",
+			ret);
+	}
+}
+
+static int pci_epf_dma_epc_init(struct pci_epf *epf)
+{
+	struct pci_epf_dma *epf_dma = epf_get_drvdata(epf);
+	const struct pci_epc_features *epc_features;
+	struct pci_epc *epc = epf->epc;
+	struct device *dev = &epf->dev;
+	int ret;
+
+	epc_features = pci_epc_get_features(epc, epf->func_no, epf->vfunc_no);
+	if (!epc_features)
+		return -EOPNOTSUPP;
+
+	pci_epf_dma_clear_metadata_status(epf_dma);
+
+	ret = pci_epc_write_header(epc, epf->func_no, epf->vfunc_no,
+				   epf->header);
+	if (ret) {
+		dev_err(dev, "configuration header write failed\n");
+		return ret;
+	}
+
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no,
+			      &epf->bar[epf_dma->metadata_bar]);
+	if (ret) {
+		dev_err(dev, "BAR%d setup failed: %d\n",
+			epf_dma->metadata_bar, ret);
+		return ret;
+	}
+
+	if (epf_dma->dma_window_addr) {
+		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no,
+				      &epf->bar[epf_dma->dma_window_bar]);
+		if (ret) {
+			dev_err(dev, "BAR%d setup failed: %d\n",
+				epf_dma->dma_window_bar, ret);
+			goto err_clear_metadata_bar;
+		}
+	}
+
+	if (epc_features->msi_capable && epf->msi_interrupts) {
+		ret = pci_epc_set_msi(epc, epf->func_no, epf->vfunc_no,
+				      epf->msi_interrupts);
+		if (ret) {
+			dev_err(dev, "MSI setup failed: %d\n", ret);
+			goto err_clear_dma_window_bar;
+		}
+	}
+
+	if (epc_features->msix_capable && epf->msix_interrupts) {
+		ret = pci_epc_set_msix(epc, epf->func_no, epf->vfunc_no,
+				       epf->msix_interrupts,
+				       epf_dma->metadata_bar,
+				       epf_dma->msix_table_offset);
+		if (ret) {
+			dev_err(dev, "MSI-X setup failed: %d\n", ret);
+			goto err_clear_dma_window_bar;
+		}
+	}
+
+	schedule_delayed_work(&epf_dma->map_work, 0);
+
+	return 0;
+
+err_clear_dma_window_bar:
+	if (epf_dma->dma_window_addr)
+		pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no,
+				  &epf->bar[epf_dma->dma_window_bar]);
+err_clear_metadata_bar:
+	pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no,
+			  &epf->bar[epf_dma->metadata_bar]);
+	pci_epf_dma_clear_metadata_status(epf_dma);
+
+	return ret;
+}
+
+static void pci_epf_dma_epc_deinit(struct pci_epf *epf)
+{
+	struct pci_epf_dma *epf_dma = epf_get_drvdata(epf);
+	struct pci_epf_bar *bar;
+
+	cancel_delayed_work_sync(&epf_dma->map_work);
+
+	if (!epf_dma->metadata_addr)
+		return;
+
+	pci_epf_dma_clear_metadata_status(epf_dma);
+	if (epf_dma->dma_window_addr) {
+		bar = &epf->bar[epf_dma->dma_window_bar];
+		pci_epc_clear_bar(epf->epc, epf->func_no, epf->vfunc_no, bar);
+		bar->submap = NULL;
+		bar->num_submap = 0;
+	}
+	pci_epc_clear_bar(epf->epc, epf->func_no, epf->vfunc_no,
+			  &epf->bar[epf_dma->metadata_bar]);
+	epf_dma->submaps_programmed = false;
+}
+
+static int pci_epf_dma_link_up(struct pci_epf *epf)
+{
+	struct pci_epf_dma *epf_dma = epf_get_drvdata(epf);
+
+	schedule_delayed_work(&epf_dma->map_work, 0);
+
+	return 0;
+}
+
+static int pci_epf_dma_link_down(struct pci_epf *epf)
+{
+	struct pci_epf_dma *epf_dma = epf_get_drvdata(epf);
+
+	cancel_delayed_work_sync(&epf_dma->map_work);
+	pci_epf_dma_set_metadata_ready(epf_dma, false);
+	/*
+	 * Link down can invalidate non-sticky inbound ATU state without going
+	 * through pci_epc_clear_bar(). Keep the BAR/submap description intact,
+	 * but force the next link-up path to reprogram the subrange mappings
+	 * for any still-pending host request.
+	 */
+	epf_dma->submaps_programmed = false;
+
+	return 0;
+}
+
+static const struct pci_epc_event_ops pci_epf_dma_event_ops = {
+	.epc_init = pci_epf_dma_epc_init,
+	.epc_deinit = pci_epf_dma_epc_deinit,
+	.link_up = pci_epf_dma_link_up,
+	.link_down = pci_epf_dma_link_down,
+};
+
+static int pci_epf_dma_bind(struct pci_epf *epf)
+{
+	struct pci_epf_dma *epf_dma = epf_get_drvdata(epf);
+	const struct pci_epc_features *epc_features;
+	struct pci_epc *epc = epf->epc;
+	bool needs_dma_window;
+	int ret;
+
+	if (WARN_ON_ONCE(!epc))
+		return -EINVAL;
+
+	epc_features = pci_epc_get_features(epc, epf->func_no, epf->vfunc_no);
+	if (!epc_features)
+		return -EOPNOTSUPP;
+
+	if (!epc_features->msi_capable && !epc_features->msix_capable)
+		return -EOPNOTSUPP;
+
+	if ((!epc_features->msi_capable || !epf->msi_interrupts) &&
+	    (!epc_features->msix_capable || !epf->msix_interrupts))
+		return -EINVAL;
+
+	ret = pci_epf_dma_collect_resources(epf_dma);
+	if (ret)
+		return ret;
+
+	if (epf_dma->metadata_bar == NO_BAR)
+		epf_dma->metadata_bar =
+			pci_epf_dma_first_usable_bar(epf_dma, epc_features,
+						     NO_BAR);
+
+	if (epf_dma->metadata_bar == NO_BAR ||
+	    !pci_epf_dma_bar_usable(epc_features, epf_dma->metadata_bar) ||
+	    pci_epf_dma_bar_has_fixed_resource(epf_dma, epf_dma->metadata_bar)) {
+		ret = -EINVAL;
+		goto err_free;
+	}
+
+	needs_dma_window = pci_epf_dma_needs_dma_window(epf_dma);
+	if (needs_dma_window) {
+		if (!epc_features->subrange_mapping ||
+		    !epc_features->dynamic_inbound_mapping) {
+			ret = -EOPNOTSUPP;
+			goto err_free;
+		}
+
+		if (epf_dma->dma_window_bar == NO_BAR)
+			epf_dma->dma_window_bar =
+				pci_epf_dma_first_usable_bar(epf_dma, epc_features,
+							     epf_dma->metadata_bar);
+		if (epf_dma->dma_window_bar == NO_BAR) {
+			ret = -EOPNOTSUPP;
+			goto err_free;
+		}
+	}
+
+	if (epf_dma->dma_window_bar != NO_BAR) {
+		if (!pci_epf_dma_bar_usable(epc_features,
+					    epf_dma->dma_window_bar)) {
+			ret = -EINVAL;
+			goto err_free;
+		}
+		if (epf_dma->metadata_bar == epf_dma->dma_window_bar ||
+		    pci_epf_dma_bar_has_fixed_resource(epf_dma,
+						       epf_dma->dma_window_bar)) {
+			ret = -EINVAL;
+			goto err_free;
+		}
+	}
+
+	ret = pci_epf_dma_build_layout(epf_dma, epc_features);
+	if (ret)
+		goto err_free;
+
+	return 0;
+
+err_free:
+	pci_epf_dma_free_layout(epf_dma);
+
+	return ret;
+}
+
+static void pci_epf_dma_unbind(struct pci_epf *epf)
+{
+	struct pci_epf_dma *epf_dma = epf_get_drvdata(epf);
+
+	cancel_delayed_work_sync(&epf_dma->map_work);
+	if (epf->epc && epf->epc->init_complete)
+		pci_epf_dma_epc_deinit(epf);
+	pci_epf_dma_free_layout(epf_dma);
+}
+
+#define PCI_EPF_DMA_SHOW(_name, _fmt, _val)				\
+static ssize_t pci_epf_dma_##_name##_show(struct config_item *item,	\
+					  char *page)			\
+{									\
+	struct config_group *group = to_config_group(item);		\
+	struct pci_epf_dma *epf_dma = to_epf_dma(group);		\
+									\
+	return sysfs_emit(page, _fmt "\n", (_val));			\
+}
+
+PCI_EPF_DMA_SHOW(metadata_bar, "%d", (int)epf_dma->metadata_bar)
+PCI_EPF_DMA_SHOW(dma_window_bar, "%d", (int)epf_dma->dma_window_bar)
+
+static ssize_t pci_epf_dma_metadata_bar_store(struct config_item *item, const char *page,
+					      size_t len)
+{
+	struct config_group *group = to_config_group(item);
+	struct pci_epf_dma *epf_dma = to_epf_dma(group);
+	int bar, ret;
+
+	if (epf_dma->epf->epc)
+		return -EOPNOTSUPP;
+
+	ret = kstrtoint(page, 0, &bar);
+	if (ret)
+		return ret;
+
+	if (bar != NO_BAR && (bar < BAR_0 || bar >= PCI_STD_NUM_BARS))
+		return -EINVAL;
+	if (bar != NO_BAR && bar == epf_dma->dma_window_bar)
+		return -EINVAL;
+
+	epf_dma->metadata_bar = bar;
+
+	return len;
+}
+
+static ssize_t pci_epf_dma_dma_window_bar_store(struct config_item *item,
+						const char *page, size_t len)
+{
+	struct config_group *group = to_config_group(item);
+	struct pci_epf_dma *epf_dma = to_epf_dma(group);
+	int bar, ret;
+
+	if (epf_dma->epf->epc)
+		return -EOPNOTSUPP;
+
+	ret = kstrtoint(page, 0, &bar);
+	if (ret)
+		return ret;
+
+	if (bar != NO_BAR && (bar < BAR_0 || bar >= PCI_STD_NUM_BARS))
+		return -EINVAL;
+	if (bar != NO_BAR && bar == epf_dma->metadata_bar)
+		return -EINVAL;
+
+	epf_dma->dma_window_bar = bar;
+
+	return len;
+}
+
+PCI_EPF_DMA_SHOW(wr_chans, "%u", (unsigned int)epf_dma->wr_chans)
+
+static ssize_t pci_epf_dma_wr_chans_store(struct config_item *item,
+					  const char *page, size_t len)
+{
+	struct config_group *group = to_config_group(item);
+	struct pci_epf_dma *epf_dma = to_epf_dma(group);
+	u16 val;
+	int ret;
+
+	if (epf_dma->epf->epc)
+		return -EOPNOTSUPP;
+
+	ret = kstrtou16(page, 0, &val);
+	if (ret)
+		return ret;
+	if (val > EDMA_MAX_WR_CH)
+		return -EINVAL;
+
+	epf_dma->wr_chans = val;
+
+	return len;
+}
+
+PCI_EPF_DMA_SHOW(rd_chans, "%u", (unsigned int)epf_dma->rd_chans)
+
+static ssize_t pci_epf_dma_rd_chans_store(struct config_item *item,
+					  const char *page, size_t len)
+{
+	struct config_group *group = to_config_group(item);
+	struct pci_epf_dma *epf_dma = to_epf_dma(group);
+	u16 val;
+	int ret;
+
+	if (epf_dma->epf->epc)
+		return -EOPNOTSUPP;
+
+	ret = kstrtou16(page, 0, &val);
+	if (ret)
+		return ret;
+	if (val > EDMA_MAX_RD_CH)
+		return -EINVAL;
+
+	epf_dma->rd_chans = val;
+
+	return len;
+}
+
+CONFIGFS_ATTR(pci_epf_dma_, metadata_bar);
+CONFIGFS_ATTR(pci_epf_dma_, dma_window_bar);
+CONFIGFS_ATTR(pci_epf_dma_, wr_chans);
+CONFIGFS_ATTR(pci_epf_dma_, rd_chans);
+
+static struct configfs_attribute *pci_epf_dma_attrs[] = {
+	&pci_epf_dma_attr_metadata_bar,
+	&pci_epf_dma_attr_dma_window_bar,
+	&pci_epf_dma_attr_wr_chans,
+	&pci_epf_dma_attr_rd_chans,
+	NULL,
+};
+
+static const struct config_item_type pci_epf_dma_group_type = {
+	.ct_attrs	= pci_epf_dma_attrs,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct config_group *pci_epf_dma_add_cfs(struct pci_epf *epf,
+						struct config_group *group)
+{
+	struct pci_epf_dma *epf_dma = epf_get_drvdata(epf);
+	struct config_group *epf_group = &epf_dma->group;
+	struct device *dev = &epf->dev;
+
+	config_group_init_type_name(epf_group, dev_name(dev),
+				    &pci_epf_dma_group_type);
+
+	return epf_group;
+}
+
+static const struct pci_epf_device_id pci_epf_dma_ids[] = {
+	{
+		.name = "pci_epf_dma",
+	},
+	{},
+};
+
+static int pci_epf_dma_probe(struct pci_epf *epf,
+			     const struct pci_epf_device_id *id)
+{
+	struct pci_epf_dma *epf_dma;
+
+	epf_dma = devm_kzalloc(&epf->dev, sizeof(*epf_dma), GFP_KERNEL);
+	if (!epf_dma)
+		return -ENOMEM;
+
+	epf->header = &pci_epf_dma_header;
+	epf->event_ops = &pci_epf_dma_event_ops;
+
+	epf_dma->epf = epf;
+	epf_dma->metadata_bar = NO_BAR;
+	epf_dma->dma_window_bar = NO_BAR;
+	INIT_DELAYED_WORK(&epf_dma->map_work, pci_epf_dma_map_work);
+
+	epf_set_drvdata(epf, epf_dma);
+
+	return 0;
+}
+
+static const struct pci_epf_ops pci_epf_dma_ops = {
+	.unbind		= pci_epf_dma_unbind,
+	.bind		= pci_epf_dma_bind,
+	.add_cfs	= pci_epf_dma_add_cfs,
+};
+
+static struct pci_epf_driver pci_epf_dma_driver = {
+	.driver.name	= "pci_epf_dma",
+	.probe		= pci_epf_dma_probe,
+	.id_table	= pci_epf_dma_ids,
+	.ops		= &pci_epf_dma_ops,
+	.owner		= THIS_MODULE,
+};
+
+static int __init pci_epf_dma_init(void)
+{
+	return pci_epf_register_driver(&pci_epf_dma_driver);
+}
+module_init(pci_epf_dma_init);
+
+static void __exit pci_epf_dma_exit(void)
+{
+	pci_epf_unregister_driver(&pci_epf_dma_driver);
+}
+module_exit(pci_epf_dma_exit);
+
+MODULE_DESCRIPTION("PCI EPF DMA DRIVER");
+MODULE_AUTHOR("Koichiro Den <den@valinux.co.jp>");
+MODULE_LICENSE("GPL");
-- 
2.51.0



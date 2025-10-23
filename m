Return-Path: <dmaengine+bounces-6935-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 878AEBFF86D
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 09:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4413F501CF2
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 07:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356FB2C11D9;
	Thu, 23 Oct 2025 07:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="elXLH84U"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010016.outbound.protection.outlook.com [52.101.229.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9F4270EA3;
	Thu, 23 Oct 2025 07:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203966; cv=fail; b=c/ldni9DkujAKlz1WX3IrPABP29HfiK0eRMm85+n6IKCFelSs3GwexBNO533VssktjOIHpDWxaBWrGlRiBY6iv/5tcdxYAYA6FjO2LKevkeTabpXtUJnZ0D+Dv03+VuOmm/YwUPNyEjddH+qFO9KnrBZU5qG7frCQXFXdVwp0ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203966; c=relaxed/simple;
	bh=+ZIhAGLa0YTEz+wtnF9rUMVErU8QLJtxvAd7knMXPdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=e9QS+TGSrEyUDql0/vyLm0xqNs7etffxq2on5whocAAuXYAkNvxHNcuVz4X97U7ehOrY9gPoz41paUs68vHqEFpHXTfWQsQKSAnaPAiWk3L0AYEzMTE512qyNROz5U9qTkwXneh0P3sJ0f3txAvSc2+xCm2zCnYmJeYqVzzFX2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=elXLH84U; arc=fail smtp.client-ip=52.101.229.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KaUfGfRMlQyoSqsuPrJsBVANl9JEyCpDQ2LgU2i5TCpcWRO4hivMo1znqhaDRK3qHRoT5kUwPHlV1HWjIeGhtgfuwH3ChZhap7ZRM0sU7PlMyAbnEhhS/HEHvq6xj0Ko6UfYdNtXXzWGDGNswJ/+6w8cdl3ddE4c2FHD+C6BKgDf5u6il6i5Zp8sgR5FmZH3sZMJkXXKzrmEgt5jArhDs9azaoUgOkmLAmnuufAMp+NIT+KA6VZzZJvX67ob966FC/42jquLnmtgwxrKmLKU0yiIowjL2DpZU9YFOyuWQyGkuHubmoZ0XYCAg6AolgQluXnrr+dcPxwU+ZfgMlgcWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sctk0cjbwQAK62FIY/HFCksb+g81AmV3Ke8NWDWRGk8=;
 b=BhPPuRUwfGwXNYmtmYHr3pjGsrSQLXZmv0Jtt8UD6p8I3KNZ3/04KiAS1ZUeHM37JBkmBrqAZkOouoGB9RUZF7ev5LRV+y+zIqcESxv37fv4lGth1VT5PAsfyxX8aouajL+DmC1mO2ntEBBkbU92GROq3lGNKIyfRlqkAawKQEIrPiHSxdYAzyOY3E3iOyRnPexA5r6VKFZQO2kIphab6JifihZJcFA7zCHZWrsGdKFwDz0+81AW0Wkjj0UdUg/HKEHGZMZ5cUaMADLuP8xlIPGeNDhWTOHI4HxVbUvkkfpe2Qe78DFmNUS2qYU2wr5w5W05R2vpUtE795qTHvVrkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sctk0cjbwQAK62FIY/HFCksb+g81AmV3Ke8NWDWRGk8=;
 b=elXLH84UXdOSDuB9LBeAZX9f+nllqg0bntKA++b4vMAaFUwYV1jw/TwXBtGHBC4rZz72WfxT0drpnAexxpo04GMIMwQ+sImbWNVkpOALvdqst0uxforRErLvYyFyh81CX4H5qXNgwigtmQlw3AKKb/CQUCORYwg/1lGyXVXsgEE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TY7P286MB5387.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:19:21 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:19:21 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
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
	Frank.Li@nxp.com,
	fancer.lancer@gmail.com,
	arnd@arndb.de,
	pstanner@redhat.com,
	elfring@users.sourceforge.net
Subject: [RFC PATCH 00/25] NTB/PCI: Add DW eDMA intr fallback and BAR MW offsets
Date: Thu, 23 Oct 2025 16:18:51 +0900
Message-ID: <20251023071916.901355-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0027.jpnprd01.prod.outlook.com
 (2603:1096:405:1::15) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TY7P286MB5387:EE_
X-MS-Office365-Filtering-Correlation-Id: e37e5e1a-369c-4809-7862-08de12047ccb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mkLCw6mXfpNBz+2+ZRnTl+mVVUQJN9eZUUraECJcQxkH8+/XknI5Sr1yw2EU?=
 =?us-ascii?Q?4Ri4XSAo6r0ala0x7j9ZRpNPw+En8TMtqw+LdCwOyxeJXVyelilxmCzqTSI+?=
 =?us-ascii?Q?uXHcG/ehjNgdFP9Lwdl+Rkl4dJt0+N7M+OUwr0anr0KH+30gX8/siM8FJsHY?=
 =?us-ascii?Q?qsYl2wTl7wtU0ABS4+vn+6fgoKpcHrQGPUVJXAbeziLUx3WubcOMRYUOVp7f?=
 =?us-ascii?Q?q3HqsZSa0d7N4xGDgq3n270TWyFY2AoaTUEv8tk12l61xdrgb0R8Tn8WIQ0F?=
 =?us-ascii?Q?W/P4cBVDEcXvMQRaCmsl9D8//nATGPvGguq1hGfjbEwq1e5NJO5rFN27LgDW?=
 =?us-ascii?Q?tyz8i+C+/Gw2PETxfmPKadfqxDcpyqv71tVAWxlyjSmHakIQ8byYGfcAYbFL?=
 =?us-ascii?Q?LsZXptUvDCYQWE9SRG2aiKMLPc9aethZmrHROL5Pf3ZTPVb3cLHV08w5LLpZ?=
 =?us-ascii?Q?BwXKCQEMhLJCjf597ijqGdYWCa+oRu5VSBcwrgmq8dlnozc74x3lkqJMdYLD?=
 =?us-ascii?Q?iExMN9wMF5eSse/N/nR97lLiLyxLibqAE0CEOk1ICXd9wR1uykqR+GffbOob?=
 =?us-ascii?Q?VJ8GdInXQMJEuejfo50fc+pXBOFdYJ8+mr6Kum82/Q/OjlMWZSPyDkblmAib?=
 =?us-ascii?Q?irYAJ3XUoKhjWS2TLjysoIxvugxR8vXeUszZP4ePLgV4VmnFtT293U1lpZOf?=
 =?us-ascii?Q?xa/WKq6Enrbsc/17v4NvewPZvVWIR5ozwXym/fp+whUz4IaKHTTVQApkZlQW?=
 =?us-ascii?Q?X/eyM9WhOMSTUdRUSjrkQGkFbZ+2/6HfrkIoop9Jrvk1wutbJGtJRkDsEOgy?=
 =?us-ascii?Q?/9iPsDpZICi1tazqH5dFHk7v3/wyzZIJsR5XgjtlZ0Q9yCzSlVKP6eG225iz?=
 =?us-ascii?Q?gy0yxUgudoHukmws3Zi6Tc3vKWuitJF6+1+2M3Cz08q86exOATh29dP9H+rt?=
 =?us-ascii?Q?pZ2LYosxSinX5BN4/qypa10+C5ho5Gu1hJX2KTehdyOrY3HTcWP0ZRAfTQOm?=
 =?us-ascii?Q?VsRFggMr8E4/8ScZm+dmJoDzGRMSWlFYXT/3rKxS/RuGEXLAlvMDxC8ZxEt2?=
 =?us-ascii?Q?51XAXA4BVvdPq+k1rpvCHS8jKWpDwATbmesk7s6/XAF0C6HUBxtj3ZxxtWkv?=
 =?us-ascii?Q?o696YNIkSuc6d9EklzHrNCgwqlHiLchyF0yPJMfYx0tzu3z4X+zrbEwTSfsv?=
 =?us-ascii?Q?FpDrmMjNkqg1kqPvewdumbpfFSBwne/AGvAgKi/rKVnH3N0IDmIH49TKsuV3?=
 =?us-ascii?Q?ltSii+u2rnE39he6B4Uf02EdZYBPzpN/lBZX2npTv8TxmdmTQe3KRCQaONI4?=
 =?us-ascii?Q?6qAzApPm03LqZc+KylT16Yc6381DUq71jw+Ql/MjaY2jMIHxFIAUkF9qeULj?=
 =?us-ascii?Q?bRaTYmWSqgO7g7Jt2VG5cdx4GC8Cs5SDkZqFMhphiVXiKSPQT8vDhP03sNMI?=
 =?us-ascii?Q?XHQHWiWfTQvxREHzFqgbe1aV5irfWari?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yjzb2VvzH7zQrxXhbi0kFjUtPUtyPxYrl13OBZ9SwXm7InZWVhfBc/ISTyDG?=
 =?us-ascii?Q?AXuglayZz8a+JibxZH0+eNjTOUg4e1/uPSdlozi1+I+Rmh2DLUK0aFtBcM3f?=
 =?us-ascii?Q?qa7KRWwOYngwSUPBW+JDQSPeFRthjAlMUJcK1rzizWNkvkxHZM4p8ZUxqokv?=
 =?us-ascii?Q?Vcv8Agg0u0L8zj3o5KBjPgc5ThXh/oTUQexBMDSAb0+6rR+j6WoBkv3MiHa1?=
 =?us-ascii?Q?W3MtkSIH5ZKNm/qJuFUpDosIdFPS22nPXPcDf0s27DHqKbFEF5ZJQlUuQHo0?=
 =?us-ascii?Q?iFiGq6Wnri3RoPvSTFuicP4kUi4M1dL6IIQliyn3rpaCash6SebNNL4P3bjA?=
 =?us-ascii?Q?kC3Yh5/f+9hJxVgbC5Z8Xu5dHpaZETqqsLtDNhYzkqXtLmp/NZkjxtB0Nw7p?=
 =?us-ascii?Q?AQ36KKnXRKs/xei/YAyfwtrMt/YtGH8TASHfcgM75FVWtqJLonYm7YjKX5gx?=
 =?us-ascii?Q?f6IY1Ze7+bK1g4x4IW9pa0r0GUGdxYRXbsxt/d83HMsexx/drrQede0/0x+a?=
 =?us-ascii?Q?kA3jTTWjXFyR4Tar7l3hai6uy4/wXpPjauOdwW8adGlNDm8mcybi+Oo8oiB1?=
 =?us-ascii?Q?w8zj1PtHqxAcQkraP+kdskKcocH3qKYpOn6IAbzulLEaLXE52g4EK8/Mi819?=
 =?us-ascii?Q?ZX7UXnbGiiqJ4NX11TM92iEhddqUSZ6fOHl+8EL2+kJSQ4t697AUbmM5A2aG?=
 =?us-ascii?Q?I7P6V3Y+3JUjmvtwIHiD04/zYIQADH/RsNBPP+wxfkwiYHmPzamNG5V3ilz+?=
 =?us-ascii?Q?4C4bf+r20tdV8Yiqh1RaIQDI9lC8hlBIL7vcDmQCiK0woZoHdLJhX1bBW5FH?=
 =?us-ascii?Q?IH9QbdCOhiKDu6+s7cou4KjP+Y8WhKfH3IGsoH9L93HDGvs0Q+hMo+5ixoqP?=
 =?us-ascii?Q?jc61jC7nlYr7byU6b+jnCXATEvD8mXH00pXYTzbgWQfbBuCiSMvz3FCrZEw2?=
 =?us-ascii?Q?nskn1bZ0ZRxAdJAFr63ye6aWZOmVPHAqXVWwwXpp2lygE9Hlpj2vh/t2v/q8?=
 =?us-ascii?Q?4o9a+3CYMRuG/mU6R5fQ2HChAmXFXdfLLezb4KIxcwwRKN7cJhQMdvHpe3P1?=
 =?us-ascii?Q?fFz46kfZ8YzSNviM+w+IwRHH6oyKzqgg7joT0kC17zmOT5Atd+jnxcQXhiSP?=
 =?us-ascii?Q?XdFEKhN5vgjigyy2+73oJKgyyB63NB3hQfqggFygofWj20iEfTzfefKZ4B33?=
 =?us-ascii?Q?EpjLhnzpumENSPM8NJ1CQ6aGAxVrik78bT0UwT/XUXM21HE+taIYQxaNG9Ef?=
 =?us-ascii?Q?CloMCOLSq0Nj8UcRVJSDK25bKv7r1FdjjFPelKaV6vVAPrjkfkfAIMTr5NYr?=
 =?us-ascii?Q?reXbZ4L+M9B87Vaj1XhhRkgkSMpvyqrR0KT/om1tcu3A2eMtrRVZ2VZNXVLJ?=
 =?us-ascii?Q?5/1exX1mCYNCAZbvS6ZVtSv9rV50kc3cGO9kV3AIHIwlOnKZbBV5IQdT/7pH?=
 =?us-ascii?Q?zKk43/Gkt9jl5q5MMc0RqzUoftAhUQgOtEhbO8Q0NBqUOcNTzDIE5i+JGTb8?=
 =?us-ascii?Q?9UynET0HZKLMIxTq9JMqZsQhViK+J3TkTLZOo2Ytb34cLRvAStpSaMeRNbLc?=
 =?us-ascii?Q?zVa5yDBHJIDsQi6LXnDgH5AjFgBbw5aafL2OwTZsrqfSFBS2CIGk4x997nzJ?=
 =?us-ascii?Q?kGEXOArMF7GxxALdIgHfPH4=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e37e5e1a-369c-4809-7862-08de12047ccb
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:19:21.7426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Nc1Pmk/8sKz3NAvrsQm8c0JBGnz9gfHMVF3IW72ldoHsWL26oRQ3WdmMi4IKzS43OAr9Z8Jx73i8vHI+V+MHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB5387

Hi all,

Motivation
==========

On Renesas R-Car S4 the PCIe Endpoint is DesignWare-based and the platform
does not allow mapping GITS_TRANSLATER as an inbound iATU target. As a
result, forwarding MSI writes from the Root Complex (RC) to the Endpoint
(EP) is not possible even if we would add implementation to create a MSI
domain for the vNTB device to use existing drivers/ntb/msi.c, and NTB
traffic must fall back to doorbells (polling). In addition, BAR resources
are scarce, which makes it difficult to dedicate a BAR solely to an
NTB/msi window.

This RFC introduces a generic interrupt backend for NTB. The existing MSI
path is converted to a backend, and a new DW eDMA test-interrupt backend
provides an RC-to-EP interrupt fallback when MSI cannot be used. In
parallel, EPC/DWC gains inbound subrange mapping so multiple NTB memory
windows (MWs) can share a single BAR at arbitrary offsets (via mwN_offset).
The vNTB EPF and ntb_transport are taught about offsets.

Backend selection is automatic: if MSI is available we use the MSI backend.
Otherwise, if enabled, the DW eDMA backend is used. If neither is
available, we continue to use doorbells. Existing systems remain unaffected
unless use_intr=1 is set.

Example layout (R-Car S4):

  BAR0: Config/Spad
  BAR2 [0x00000-0xF0000]: MW1 (data)
  BAR2 [0xF0000-0xF8000]: MW2 (interrupts)
  BAR4: Doorbell

  # The corresponding configfs settings (see Patch #25):
  echo 0xF0000 > ./mw1
  echo 0x8000  > ./mw2
  echo 0xF0000 > ./mw2_offset
  echo 2       > ./mw1_bar
  echo 2       > ./mw2_bar

Summary of changes
==================

* NTB core/transport
  - Introduce struct ntb_intr_backend and convert MSI to the new backend.
  - Add DW eDMA interrupt backend (CONFIG_NTB_DW_EDMA) as MSI-less fallback.
  - Rename module parameter to use_intr (keep use_msi as deprecated alias).
  - Support offsetted partial MWs in ntb_transport.
  - Hardening for peer-reported interrupt values and minor cleanups.

* PCI Endpoint core and DWC EP controller
  - Add EPC ops map_inbound()/unmap_inbound() for BAR subrange mapping.
  - Implement inbound mapping for DesignWare EP (Address Match mode), with
    tracking of multiple inbound iATU entries per BAR and proper teardown.

* EPF vNTB
  - Add mwN_offset configfs attributes and propagate offsets to inbound maps.
  - Prefer pci_epc_map_inbound() when supported. Otherwise fall back to
    set_bar().
  - Provide .get_pci_epc() so backends can locate the common eDMA instance.

* DW eDMA
  - Add self-interrupt registration and expose test-IRQ register offsets.
  - Provide dw_edma_find_by_child().

* Renesas R-Car
  - Place MW2 in BAR2 to host the interrupt window alongside the data MW.

* Documentation

Patch layout
============

* Patches 01-11 : BAR subrange and MW offsets (EPC/DWC EP, vNTB, core helpers)
* Patches 12-14 : Interrupt handling hardening in ntb_transport/MSI
* Patches 15-17 : DW eDMA: self-IRQ API, offsets, lookup helper
* Patches 18-19 : NTB/EPF glue (.get_pci_epc())
* Patch 20      : Module param name change (use_msi->use_intr, alias preserved)
* Patches 21-23 : Generic interrupt backend + MSI conversion + DW eDMA backend
* Patch 24      : R-Car: add MW2 in BAR2 for interrupts
* Patch 25      : Documentation updates

Tested on
=========

* Renesas R-Car S4 Spider
* Kernel base: commit 68113d260674 ("NTB/msi: Remove unused functions") (ntb-driver-core/ntb-next)

Performance measurement
=======================

Even without the DMA acceleration patches for R-Car S4 (which I keep
separate from this RFC patch series), enabling RC-to-EP interrupts
dramatically improves NTB latency on R-Car S4:

* Before this patch series (NB. use_msi doesn't work on R-Car S4)

  # Server: sockperf server -i 0.0.0.0
  # Client: sockperf ping-pong -i $SERVER_IP
  ========= Printing statistics for Server No: 0
  [Valid Duration] RunTime=0.540 sec; SentMessages=45; ReceivedMessages=45
  ====> avg-latency=5995.680 (std-dev=70.258, mean-ad=57.478, median-ad=85.978,\
        siqr=59.698, cv=0.012, std-error=10.473, 99.0% ci=[5968.702, 6022.658])
  # dropped messages = 0; # duplicated messages = 0; # out-of-order messages = 0
  Summary: Latency is 5995.680 usec
  Total 45 observations; each percentile contains 0.45 observations
  ---> <MAX> observation = 6121.137
  ---> percentile 99.999 = 6121.137
  ---> percentile 99.990 = 6121.137
  ---> percentile 99.900 = 6121.137
  ---> percentile 99.000 = 6121.137
  ---> percentile 90.000 = 6099.178
  ---> percentile 75.000 = 6054.418
  ---> percentile 50.000 = 5993.040
  ---> percentile 25.000 = 5935.021
  ---> <MIN> observation = 5883.362

* With this series (use_intr=1)

  # Server: sockperf server -i 0.0.0.0
  # Client: sockperf ping-pong -i $SERVER_IP
  ========= Printing statistics for Server No: 0
  [Valid Duration] RunTime=0.550 sec; SentMessages=2145; ReceivedMessages=2145
  ====> avg-latency=127.677 (std-dev=21.719, mean-ad=11.759, median-ad=3.779,\
        siqr=2.699, cv=0.170, std-error=0.469, 99.0% ci=[126.469, 128.885])
  # dropped messages = 0; # duplicated messages = 0; # out-of-order messages = 0
  Summary: Latency is 127.677 usec
  Total 2145 observations; each percentile contains 21.45 observations
  ---> <MAX> observation =  446.691
  ---> percentile 99.999 =  446.691
  ---> percentile 99.990 =  446.691
  ---> percentile 99.900 =  291.234
  ---> percentile 99.000 =  221.515
  ---> percentile 90.000 =  149.277
  ---> percentile 75.000 =  124.497
  ---> percentile 50.000 =  121.137
  ---> percentile 25.000 =  119.037
  ---> <MIN> observation =  113.637

Feedback welcome on both the approach and the splitting/routing preference.

(The series spans NTB, PCI EP/DWC and dmaengine/dw-edma. I'm happy to split
later if preferred.)

Thanks for reviewing.


Koichiro Den (25):
  PCI: endpoint: pci-epf-vntb: Use array_index_nospec() on mws_size[]
    access
  PCI: endpoint: pci-epf-vntb: Add mwN_offset configfs attributes
  NTB: epf: Handle mwN_offset for inbound MW regions
  PCI: endpoint: Add inbound mapping ops to EPC core
  PCI: dwc: ep: Implement EPC inbound mapping support
  PCI: endpoint: pci-epf-vntb: Use pci_epc_map_inbound() for MW mapping
  NTB: Add offset parameter to MW translation APIs
  PCI: endpoint: pci-epf-vntb: Propagate MW offset from configfs when
    present
  NTB: ntb_transport: Support offsetted partial memory windows
  NTB/msi: Support offsetted partial memory window for MSI
  NTB/msi: Do not force MW to its maximum possible size
  NTB: ntb_transport: Stricter checks for peer-reported interrupt values
  NTB/msi: Skip mw_set_trans() if already configured
  NTB/msi: Add a inner loop for PCI-MSI cases
  dmaengine: dw-edma: Add self-interrupt registration API
  dmaengine: dw-edma: Expose self-IRQ register offsets
  dmaengine: dw-edma: Add dw_edma_find_by_child() helper
  NTB: core: Add .get_pci_epc() to ntb_dev_ops
  NTB: epf: vntb: Implement .get_pci_epc() callback
  NTB: ntb_transport: Rename use_msi to use_intr (keep alias)
  NTB: Introduce generic interrupt backend abstraction and convert MSI
  NTB: ntb_transport: Rename MSI symbols to generic interrupt form
  NTB: intr_dw_edma: Add DW eDMA emulated interrupt backend
  NTB: epf: Add MW2 for interrupt use on Renesas R-Car
  Documentation: PCI: endpoint: pci-epf-vntb: Update and add mwN_offset
    usage

 Documentation/PCI/endpoint/pci-vntb-howto.rst |  16 +-
 drivers/dma/dw-edma/dw-edma-core.c            | 109 ++++++++
 drivers/dma/dw-edma/dw-edma-core.h            |  18 ++
 drivers/dma/dw-edma/dw-edma-v0-core.c         |  15 ++
 drivers/ntb/Kconfig                           |  15 ++
 drivers/ntb/Makefile                          |   6 +-
 drivers/ntb/hw/amd/ntb_hw_amd.c               |   6 +-
 drivers/ntb/hw/epf/ntb_hw_epf.c               |  46 ++--
 drivers/ntb/hw/idt/ntb_hw_idt.c               |   3 +-
 drivers/ntb/hw/intel/ntb_hw_gen1.c            |   6 +-
 drivers/ntb/hw/intel/ntb_hw_gen1.h            |   2 +-
 drivers/ntb/hw/intel/ntb_hw_gen3.c            |   3 +-
 drivers/ntb/hw/intel/ntb_hw_gen4.c            |   6 +-
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c        |   6 +-
 drivers/ntb/intr_common.c                     |  61 +++++
 drivers/ntb/intr_dw_edma.c                    | 253 ++++++++++++++++++
 drivers/ntb/msi.c                             | 186 +++++++------
 drivers/ntb/ntb_transport.c                   | 155 ++++++-----
 drivers/ntb/test/ntb_msi_test.c               |  26 +-
 drivers/ntb/test/ntb_perf.c                   |   4 +-
 drivers/ntb/test/ntb_tool.c                   |   6 +-
 .../pci/controller/dwc/pcie-designware-ep.c   | 242 +++++++++++++++--
 drivers/pci/controller/dwc/pcie-designware.c  |   1 +
 drivers/pci/controller/dwc/pcie-designware.h  |   2 +
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 197 ++++++++++++--
 drivers/pci/endpoint/pci-epc-core.c           |  44 +++
 include/linux/dma/edma.h                      |  31 +++
 include/linux/ntb.h                           | 134 +++++++---
 include/linux/pci-epc.h                       |  11 +
 29 files changed, 1310 insertions(+), 300 deletions(-)
 create mode 100644 drivers/ntb/intr_common.c
 create mode 100644 drivers/ntb/intr_dw_edma.c

-- 
2.48.1



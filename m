Return-Path: <dmaengine+bounces-10823-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJ5TDsruE2rMHgcAu9opvQ
	(envelope-from <dmaengine+bounces-10823-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:40:10 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0EC5C69E9
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4CB030570C7
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 06:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3FB3A7F40;
	Mon, 25 May 2026 06:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="guDTLl0S"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020124.outbound.protection.outlook.com [52.101.228.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0DA3A873B;
	Mon, 25 May 2026 06:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779690915; cv=fail; b=t1HolxvmxIOC7Y4xmJCETMQGOG3idfvy5J14RCFClo/cTbP6HWqeOV/WioeIFKCUu3/kkcWLl7xb611HIiZ9/qEmBsGj1rYXoZDa+GksmtHK8JzZFQfO05IB2MJcdAZyBbHSsoOOHSyk8eSclJlefNKJKMBdyntQ2Lh8Esrog2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779690915; c=relaxed/simple;
	bh=OHBckopUI9ctDjp9Yu+5Z2vhucipY5wTC1m0v++4Z6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eEelnl80qNXRONDpVU5JKbzAvq8wZd2VUTGDyluHSwz/EGFQjGA3kNDeNxASU0ebmPx1hghcpGWoNP/pjCE5n0tji8aWTdxoDbkM5TZCWnEU+QUqRQk9R0vhN/R7iuHZiccb68u88lP/PvUEGhXU760bkk42rhtN/H7EA8Fyj/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=guDTLl0S; arc=fail smtp.client-ip=52.101.228.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NI5GLQjxNarNANswcGkJujh+sDuGLJ2ONZm3fCHIkTq7fvcTmxVxJhiV3DQPCam7EM6ug4YelKeWQcIoh+v7efX24J0DbHMHjmfftrH7TNeKeJ1tSGGdzx9E71CqFUaT7GSh0RUp1BC8pOejOCqjqbGh+QirbT3KochSnr92JzDeOfJGdiCPWa4JAOC3L66sKTW18rkuVPycHwMC0vZ43JDabi51XZJZlDBCB/lNIR9HaFBhaEnlzFxnU1a6rpQA+i/pDR0HaT9lxYHdWctAgxodTAGULGbB0xIGhlSACxj5ow00WMm73sy6zKnc/V8Bbl2NYal2dZy1efRkzO8ZUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IiGl0PRLctHcA50H3dSn2FqHQPrnfEUK5Hr3FO62nAE=;
 b=GpdErSXwS0lzq+QDdnhrcE6TWbHwpdmzFv2G3bRh8aLntcWN3k2MmGp2qq5Ia9PUUVbtmFkrVXx2Em34yd4eaf87Jzrw6d5robBINJ3vuVptgzT/C9dSvkKSa7zAbR4CCSbdL46/FUtlWEFISdKpLnFj13wMUO9AY0fbuOWznLKZiWZA4Mg5hCK1W7YWGd3gCEwSq348uE4D6eLuVit9oPLQN8BDjad7DDgLBFSzcw4RybqrOTaEQmBGr8xsukVjDdLdvp8Kx0nYRVU7r0zMiVRPck6DUcdpECYD0hH2V/SN4nWpEowz75AaAJEk595l1cDYUBkfhJaQ1yrRDHZHlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiGl0PRLctHcA50H3dSn2FqHQPrnfEUK5Hr3FO62nAE=;
 b=guDTLl0SQgQD02eM3QUt1Nxjsyv+adVsdbkhgdqWgHLKLDP/WRCD9PWLWtJJopP+ZyfHxNSr9NpwxEkc4w7NKXs3Oac+nO1WVPiv/MTKUKU8HJC7D4pU2oLudSmaNvkdzGCRKHM7VMAns+hfyRXC5Z4iR96DLTj/7gG49TwbOx0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS3P286MB2042.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:191::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 06:35:00 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 06:35:00 +0000
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
Subject: [PATCH v2 1/3] dmaengine: dw-edma-pcie: Discover endpoint DMA metadata
Date: Mon, 25 May 2026 15:34:54 +0900
Message-ID: <20260525063456.3317509-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260525063456.3317509-1-den@valinux.co.jp>
References: <20260525063456.3317509-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0009.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS3P286MB2042:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a9bfbd3-0d78-4ab1-ab8f-08deba27be2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|376014|921020|3023799007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3AApdJaVttNpH9C1ZhtOyJsdlSnHKlnRDRYpfHjUbHT9r6+3qcZplpehiIyxzl/eIQgfa3k4J1Q452BU+KCArDNgpF0QZERMblFyhrvIn3O/fU5Nf7pvXw806w1kytK8a/VDDOh8ffkPcuzlDzPeAJZ3EAn3vbftgWmvhu3z4zcQu0Hc8Ux8andA6SaxzB9bsO9Hxq7n7XbS2plkQdcUT9CrIoIEAA5xZTQNaS9myp5KE5gsY2ZRi0b49hVHwLL0vWHAz4YxtLWnx4CAgo47kWkoD/gB752NAyUb7TgQG5Ig5lgFZ71L+Nj8G5EFwcXlM9z3LPFYJ7hkIwriMt8cCNMPeXtmhJ28Anj0/zq5kd2KhNIvV638OAhbaNHEYhBT5bVfg9XpQJeNBLKDkJ2v/5TYOpHUzsgvahBVQpsA0sddipb8bRo8C/ucZDIKmy5ip4j6K3VeKsaHzIl2tGHBWcjcNbMF0J0CQG+W9tHn5aV/J6nP/nfdAd6FKr9CX4LqZgirFqbtuh02O2Czj2mbahrirNTpLTPh+jlPkDiwRH/KsvDCsUc12NcJApKYYaLgSBCn6FfZoT7L5EW4qex/E4J6ASmqrlT3kX8N2NN6xVC5oruMahBpnuMxoHtf7KdfEoChUL48fhWgHBWf/eNgtAubuUlDB9tG7Lc7auCArYg2nh6D73OJIQYii5Ruj5tE3Myv7HMywoOOPm5779aJ4oOAo7wGDPpx6GaDp69L6A8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014)(921020)(3023799007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hjmsbt99/0wT9s37FmkboTqtdCbaOk+qzfs+N1yqfjPEjID/QsfhaWfLh/Ao?=
 =?us-ascii?Q?v3p+WqDgODUmlbCQtMvOTVdeJoCH5goMqL9mjwvUFa2zck8jwj89cGOjSpPv?=
 =?us-ascii?Q?DJGWRXez9qNTRUFiNDiFmNMhWjyxnvQypyUtPXdvy7f/naXFPvevhFYMJF9j?=
 =?us-ascii?Q?mzI8UgR0wP5M9xqjfb1Bmw8T4AiHEKCtcywJRI4ZNlUvTpY5Z/cuUWk5z0SM?=
 =?us-ascii?Q?VAcAeO9D8NF6gfRgTZCUTbjAhjEMg8y+kNg8IoSK//JukYQGiFGEKiGmRN2C?=
 =?us-ascii?Q?6wNTPkahanchpYC9cH2eW6WHFCgs031u6hMoWC7DZ2TlcikjFG7HEX1a5gpz?=
 =?us-ascii?Q?ZT4I0hG8Z+eX9CiZiTyIQuwN3O352OpsN+7EYpphEG/DXb3oji9fKgcpXDT9?=
 =?us-ascii?Q?FLIXUI6U0WL9pvj+vqI6bxg+kYvCIp05k4j0cC2LSR04VrDS7dAIWv92uFWl?=
 =?us-ascii?Q?X0Dp1izRB9oE4ai0cithC3+wIRG0HM9WkiCsWiPVNxL6PvdG1eiS339jboqW?=
 =?us-ascii?Q?akHW3xqiX2cTyrUDiWLXGHi8oFkp0qWnhjZq6jlf/QZNxCMsGwYW5KB726/p?=
 =?us-ascii?Q?ouPIQqy87ErZkbOmAUYQrUO7bVuZLVPQLo4diJry1NyvIagu80ySexLdSwrn?=
 =?us-ascii?Q?DBS/zUO8Udrvfiy1rKkm60NTnI/wGpyChowDw/bLltjy6X7CxZTAvh2rTB7o?=
 =?us-ascii?Q?QPYTxrn5bcDskYXy7T2W6V0jq26TTEIIsDVfoeaza4g/rHAbRQcbj2vyhw/c?=
 =?us-ascii?Q?rd34a0a6JGtzPxV8LKfz2tVMoGqbCBRIqBIJ+8LVtcdMLuUs3I5s5VxoY56l?=
 =?us-ascii?Q?KtOJozZhzXDBB0iL7vBEfgWwb0YVxxVVqoeCOrqRAdhkqLmOnLOlv8V4u3ks?=
 =?us-ascii?Q?Wtnbqd1dHj23MGg8U2/zePkvJh/8fMPa+ZttRL3XtFxPsGqDogAHOUbV1Mgj?=
 =?us-ascii?Q?Y+U0bs/966mcsCDoN74Sed6WibEaK6/w8rp2AuSPAhxzDSGDXFRwUg7LKoCS?=
 =?us-ascii?Q?zfsCUSkIuvhnkdZPOe/XWIkaN+oYnhT0eTQtAKsLqSqB+8JXoyRBub7nd/V0?=
 =?us-ascii?Q?5RTpbGlr5f/O92PLHvadr1cL43hE0iTW+0p3HuFFIUJXz5XpRt1B9IJTFQIz?=
 =?us-ascii?Q?wr1Hk/2jX/tl/jVs2CdPFKFrxt2ejPc5e8BTcBfHjuEhrEOD01WPDT9p0mSM?=
 =?us-ascii?Q?JeoeEYOReIKicMoGcx9qSQjyH181wk6IcHJq3AgRvape5KRi0srO5Fmj56aK?=
 =?us-ascii?Q?6LhkIc3me7zNvcdMNQv+YPMkQzAmZWDZ+3ExCDBzmPa4W6M6RF9xwfHbYph9?=
 =?us-ascii?Q?jTVgG6Tkl8i+5VIpyXh5GQSkbJOO3vAgUjT9a1+QV1+A52qXHTjoB1WsWUrj?=
 =?us-ascii?Q?pUr1WXVoyrOAS8eW1Frp3k1yijhcQDXI88bdisss1U624k4Wiac7/e6W8kwW?=
 =?us-ascii?Q?XYLQ6F+dd6CrACppoSh+7J64uc89uBvdOh4qPRL7R0/He8jBlZHapa3c8b2M?=
 =?us-ascii?Q?LsVjh7ZXLAIDZ1OK7qsvru7ppjC0WFqmjVHy/CbF3N+MHPqHa8awqEyGvRHV?=
 =?us-ascii?Q?Trb54OFKboqrIUSQCsuH25tVaHULSuYZTGaGVNNt+RR5MNIQcerJZ4BIdla+?=
 =?us-ascii?Q?bvC5+sL945PI0Kr5VXkE4yTb+0WOI8ArDycNlz+38E+jSMb6+JgW0kqap07q?=
 =?us-ascii?Q?13s9d92TQi9r8C/ils/ikj3YDIky0kg9ehrQcmT32NBsDXoSKQLXweXXLh14?=
 =?us-ascii?Q?2/Dl0wlv9aH3Axvk0U/gugYgOcPM/oIkEN5w09B4FsIIxkzxitB5?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a9bfbd3-0d78-4ab1-ab8f-08deba27be2e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:34:59.1208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XsrgI32VUJ+9TNhD+sp/Jr9lE+s2IV9IiKqOnISKOc99VYWaHGZ3FZQj45Nlj94iH652KL5hZQD4ANVK1Ipoig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2042
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10823-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: 8E0EC5C69E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Teach dw-edma-pcie to discover a PCI endpoint DMA function from
BAR-resident metadata. The metadata supplies the DMA register window,
channel counts, descriptor windows, optional auxiliary windows, and
endpoint-local descriptor and auxiliary addresses.

Endpoint-provided DMA channels use raw slave addresses because the host
programs transfers against endpoint physical addresses, not PCI BAR
addresses. Scope the default remote interrupt mode to the endpoint DMA
metadata match entry so EDDA and MDB keep their existing local interrupt
behavior.

Endpoint DMA metadata can be discovered after an explicit bind through
driver_override or a dynamic ID. For such binds, there is no static
match data, so the driver falls back to the generic endpoint DMA
metadata parser.

The endpoint polls HOST_REQ at a low idle rate before programming DMA
window submaps and setting READY. Let the host wait for several endpoint
poll periods before treating the READY handshake as timed out.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - Add raw-address platform ops and select them from the endpoint DMA
    match entry.

 drivers/dma/dw-edma/dw-edma-pcie.c | 374 ++++++++++++++++++++++++++++-
 1 file changed, 373 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 12229a9301cd..7e173ad01220 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -11,9 +11,13 @@
 #include <linux/pci.h>
 #include <linux/device.h>
 #include <linux/dma/edma.h>
+#include <linux/iopoll.h>
 #include <linux/pci-epf.h>
 #include <linux/msi.h>
 #include <linux/bitfield.h>
+#include <linux/io.h>
+#include <linux/overflow.h>
+#include <linux/pci-ep-dma.h>
 #include <linux/sizes.h>
 
 #include "dw-edma-core.h"
@@ -44,6 +48,9 @@
 #define DW_PCIE_XILINX_MDB_DT_OFF_GAP		0x100000
 #define DW_PCIE_XILINX_MDB_DT_SIZE		0x800
 
+#define DW_PCIE_EP_DMA_READY_POLL_US		1000
+#define DW_PCIE_EP_DMA_READY_TIMEOUT_US		2000000
+
 #define DW_BLOCK(a, b, c) \
 	{ \
 		.bar = a, \
@@ -94,6 +101,12 @@ struct dw_edma_pcie_match_data {
 #define DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF	BIT(0)
 #define DW_EDMA_PCIE_F_REG_OFFSET	BIT(1)
 
+struct dw_edma_pcie_ep_dma_view {
+	struct pci_dev *pdev;
+	void __iomem *base;
+	resource_size_t limit;
+};
+
 static const struct dw_edma_pcie_data snps_edda_data = {
 	/* eDMA registers location */
 	.rg.bar				= BAR_0,
@@ -145,6 +158,13 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
 	.rd_ch_cnt			= 8,
 };
 
+static const struct dw_edma_pcie_data ep_dma_data = {
+	.mf				= EDMA_MF_EDMA_UNROLL,
+	.irqs				= EDMA_MAX_WR_CH + EDMA_MAX_RD_CH,
+	.wr_ch_cnt			= EDMA_MAX_WR_CH,
+	.rd_ch_cnt			= EDMA_MAX_RD_CH,
+};
+
 static void dw_edma_set_chan_region_offset(struct dw_edma_pcie_data *pdata,
 					   enum pci_barno bar, off_t start_off,
 					   off_t ll_off_gap, size_t ll_size,
@@ -214,6 +234,86 @@ static const struct dw_edma_plat_ops dw_edma_pcie_plat_ops = {
 	.pci_address = dw_edma_pcie_address,
 };
 
+static const struct dw_edma_plat_ops dw_edma_pcie_raw_addr_plat_ops = {
+	.irq_vector = dw_edma_pcie_irq_vector,
+};
+
+static bool dw_edma_pcie_valid_bar(enum pci_barno bar)
+{
+	return bar >= BAR_0 && bar <= BAR_5;
+}
+
+static bool dw_edma_pcie_valid_bar_range(struct pci_dev *pdev,
+					 enum pci_barno bar, u64 off,
+					 size_t sz)
+{
+	resource_size_t bar_len;
+
+	if (!dw_edma_pcie_valid_bar(bar) || !sz)
+		return false;
+
+	bar_len = pci_resource_len(pdev, bar);
+
+	return off <= bar_len && sz <= bar_len - off;
+}
+
+static bool dw_edma_pcie_valid_block(struct pci_dev *pdev,
+				     const struct dw_edma_block *block)
+{
+	return dw_edma_pcie_valid_bar_range(pdev, block->bar, block->off,
+					    block->sz);
+}
+
+static bool dw_edma_pcie_ep_dma_bar_scannable(struct pci_dev *pdev,
+					      enum pci_barno bar)
+{
+	unsigned long flags = pci_resource_flags(pdev, bar);
+
+	if (!(flags & IORESOURCE_MEM))
+		return false;
+
+	if (flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED))
+		return false;
+
+	return pci_resource_len(pdev, bar) >= PCI_EP_DMA_METADATA_HDR_LEN;
+}
+
+static u32 dw_edma_pcie_ep_dma_readl(struct dw_edma_pcie_ep_dma_view *view,
+				     u16 off)
+{
+	return readl(view->base + off);
+}
+
+static void dw_edma_pcie_ep_dma_writel(struct dw_edma_pcie_ep_dma_view *view,
+				       u16 off, u32 val)
+{
+	writel(val, view->base + off);
+}
+
+static u64 dw_edma_pcie_ep_dma_read64(struct dw_edma_pcie_ep_dma_view *view,
+				      u16 lo, u16 hi)
+{
+	u64 val;
+
+	val = dw_edma_pcie_ep_dma_readl(view, hi);
+
+	return (val << 32) | dw_edma_pcie_ep_dma_readl(view, lo);
+}
+
+static int dw_edma_pcie_ep_dma_read_off(struct dw_edma_pcie_ep_dma_view *view,
+					u16 lo, u16 hi, off_t *off)
+{
+	u64 val;
+
+	val = dw_edma_pcie_ep_dma_read64(view, lo, hi);
+	if (val > type_max(*off))
+		return -EINVAL;
+
+	*off = val;
+
+	return 0;
+}
+
 static void dw_edma_pcie_get_synopsys_dma_data(struct pci_dev *pdev,
 					       struct dw_edma_pcie_data *pdata)
 {
@@ -315,6 +415,265 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
 	pdata->devmem_phys_off = off;
 }
 
+static int
+dw_edma_pcie_parse_ep_dma_ch_table(struct dw_edma_pcie_ep_dma_view *view,
+				   struct dw_edma_pcie_data *pdata,
+				   u16 table_off, u16 entry_size, u16 ch_cnt,
+				   bool write)
+{
+	struct dw_edma_block *desc_blocks = write ? pdata->ll_wr : pdata->ll_rd;
+	struct dw_edma_block *data_blocks = write ? pdata->dt_wr : pdata->dt_rd;
+	u32 ctrl;
+	u16 i;
+	int ret;
+
+	for (i = 0; i < ch_cnt; i++) {
+		struct dw_edma_block *desc_block = &desc_blocks[i];
+		struct dw_edma_block *data_block = &data_blocks[i];
+		u16 off = table_off + i * entry_size;
+		u16 field, lo, hi;
+
+		field = off + PCI_EP_DMA_METADATA_CH_CTRL;
+		ctrl = dw_edma_pcie_ep_dma_readl(view, field);
+		if (FIELD_GET(PCI_EP_DMA_METADATA_CH_CTRL_HW_CH, ctrl) != i)
+			return -EOPNOTSUPP;
+
+		desc_block->bar =
+			FIELD_GET(PCI_EP_DMA_METADATA_CH_CTRL_DESC_BAR, ctrl);
+		lo = off + PCI_EP_DMA_METADATA_CH_DESC_OFF_LO;
+		hi = off + PCI_EP_DMA_METADATA_CH_DESC_OFF_HI;
+		ret = dw_edma_pcie_ep_dma_read_off(view, lo, hi,
+						   &desc_block->off);
+		if (ret)
+			return ret;
+		field = off + PCI_EP_DMA_METADATA_CH_DESC_SIZE;
+		desc_block->sz = dw_edma_pcie_ep_dma_readl(view, field);
+		lo = off + PCI_EP_DMA_METADATA_CH_DESC_ADDR_LO;
+		hi = off + PCI_EP_DMA_METADATA_CH_DESC_ADDR_HI;
+		desc_block->paddr =
+			dw_edma_pcie_ep_dma_read64(view, lo, hi);
+		desc_block->paddr_valid = true;
+		if (!dw_edma_pcie_valid_block(view->pdev, desc_block))
+			return -EINVAL;
+
+		*data_block = (struct dw_edma_block) { .bar = NO_BAR };
+		if (!(ctrl & PCI_EP_DMA_METADATA_CH_CTRL_AUX_VALID))
+			continue;
+
+		data_block->bar =
+			FIELD_GET(PCI_EP_DMA_METADATA_CH_CTRL_AUX_BAR, ctrl);
+		lo = off + PCI_EP_DMA_METADATA_CH_AUX_OFF_LO;
+		hi = off + PCI_EP_DMA_METADATA_CH_AUX_OFF_HI;
+		ret = dw_edma_pcie_ep_dma_read_off(view, lo, hi,
+						   &data_block->off);
+		if (ret)
+			return ret;
+		field = off + PCI_EP_DMA_METADATA_CH_AUX_SIZE;
+		data_block->sz = dw_edma_pcie_ep_dma_readl(view, field);
+		lo = off + PCI_EP_DMA_METADATA_CH_AUX_ADDR_LO;
+		hi = off + PCI_EP_DMA_METADATA_CH_AUX_ADDR_HI;
+		data_block->paddr =
+			dw_edma_pcie_ep_dma_read64(view, lo, hi);
+		data_block->paddr_valid = true;
+		if (!dw_edma_pcie_valid_block(view->pdev, data_block))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int
+dw_edma_pcie_ep_dma_wait_ready(struct dw_edma_pcie_ep_dma_view *view)
+{
+	u32 val;
+
+	return read_poll_timeout(dw_edma_pcie_ep_dma_readl, val,
+				 val & PCI_EP_DMA_METADATA_CTRL_READY,
+				 DW_PCIE_EP_DMA_READY_POLL_US,
+				 DW_PCIE_EP_DMA_READY_TIMEOUT_US, false,
+				 view, PCI_EP_DMA_METADATA_CTRL);
+}
+
+static int
+dw_edma_pcie_validate_ep_dma_metadata(struct dw_edma_pcie_ep_dma_view *view,
+				      u32 *metadata_ctrl, u8 *reg_layout_data)
+{
+	size_t table_size, table_end;
+	enum pci_barno reg_bar;
+	u16 len, entry_size;
+	u16 wr_ch_cnt, rd_ch_cnt;
+	u8 layout, layout_data;
+	u32 val;
+
+	val = dw_edma_pcie_ep_dma_readl(view, 0);
+	if (val != PCI_EP_DMA_METADATA_MAGIC)
+		return -ENODEV;
+
+	val = dw_edma_pcie_ep_dma_readl(view, PCI_EP_DMA_METADATA_HDR);
+	if (FIELD_GET(PCI_EP_DMA_METADATA_HDR_REV, val) !=
+	    PCI_EP_DMA_METADATA_REV)
+		return -EINVAL;
+
+	len = FIELD_GET(PCI_EP_DMA_METADATA_HDR_LEN_FIELD, val);
+	if (len < PCI_EP_DMA_METADATA_HDR_LEN)
+		return -EINVAL;
+	if (len > view->limit)
+		return -EINVAL;
+
+	val = dw_edma_pcie_ep_dma_readl(view, PCI_EP_DMA_METADATA_REG_LAYOUT);
+	layout = FIELD_GET(PCI_EP_DMA_METADATA_REG_LAYOUT_ID, val);
+	if (layout != PCI_EP_DMA_METADATA_REG_LAYOUT_DW_EDMA)
+		return -EOPNOTSUPP;
+
+	layout_data = FIELD_GET(PCI_EP_DMA_METADATA_REG_LAYOUT_DATA, val);
+	if (layout_data == EDMA_MF_EDMA_LEGACY ||
+	    layout_data == EDMA_MF_HDMA_NATIVE)
+		return -EOPNOTSUPP;
+	if (layout_data != EDMA_MF_EDMA_UNROLL &&
+	    layout_data != EDMA_MF_HDMA_COMPAT)
+		return -EINVAL;
+
+	val = dw_edma_pcie_ep_dma_readl(view, PCI_EP_DMA_METADATA_CTRL);
+	reg_bar = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_REG_BAR, val);
+	if (!dw_edma_pcie_valid_bar(reg_bar))
+		return -EINVAL;
+
+	wr_ch_cnt = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_WR_CH_COUNT, val);
+	rd_ch_cnt = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_RD_CH_COUNT, val);
+	if (!wr_ch_cnt && !rd_ch_cnt)
+		return -EINVAL;
+	if (wr_ch_cnt > EDMA_MAX_WR_CH || rd_ch_cnt > EDMA_MAX_RD_CH)
+		return -EINVAL;
+
+	entry_size = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_CH_ENTRY_SIZE, val);
+	if (entry_size < PCI_EP_DMA_METADATA_CH_ENTRY_SIZE ||
+	    entry_size % sizeof(u32))
+		return -EINVAL;
+
+	if (check_mul_overflow((size_t)(wr_ch_cnt + rd_ch_cnt),
+			       (size_t)entry_size, &table_size) ||
+	    check_add_overflow((size_t)PCI_EP_DMA_METADATA_HDR_LEN,
+			       table_size, &table_end) ||
+	    table_end > len)
+		return -EINVAL;
+
+	if (metadata_ctrl)
+		*metadata_ctrl = val;
+	if (reg_layout_data)
+		*reg_layout_data = layout_data;
+
+	return 0;
+}
+
+static int
+dw_edma_pcie_parse_ep_dma_data(struct dw_edma_pcie_ep_dma_view *view,
+			       struct dw_edma_pcie_data *pdata)
+{
+	u32 ctrl, reg_sz;
+	u8 reg_layout_data;
+	u64 reg_off;
+	u16 wr_table, rd_table, entry_size;
+	u16 wr_ch_cnt, rd_ch_cnt;
+	int ret;
+
+	ret = dw_edma_pcie_validate_ep_dma_metadata(view, &ctrl,
+						    &reg_layout_data);
+	if (ret)
+		return ret;
+
+	pci_dbg(view->pdev, "Detected PCI endpoint DMA BAR metadata\n");
+
+	pdata->mf = reg_layout_data;
+	pdata->rg.bar = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_REG_BAR, ctrl);
+
+	wr_ch_cnt = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_WR_CH_COUNT, ctrl);
+	rd_ch_cnt = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_RD_CH_COUNT, ctrl);
+	pdata->wr_ch_cnt = min_t(u16, pdata->wr_ch_cnt, wr_ch_cnt);
+	pdata->rd_ch_cnt = min_t(u16, pdata->rd_ch_cnt, rd_ch_cnt);
+	pdata->irqs = pdata->wr_ch_cnt + pdata->rd_ch_cnt;
+	reg_off = dw_edma_pcie_ep_dma_read64(view,
+					     PCI_EP_DMA_METADATA_REG_OFF_LO,
+					     PCI_EP_DMA_METADATA_REG_OFF_HI);
+	reg_sz = dw_edma_pcie_ep_dma_readl(view, PCI_EP_DMA_METADATA_REG_SIZE);
+	if (reg_off > type_max(pdata->rg.off) ||
+	    !dw_edma_pcie_valid_bar_range(view->pdev, pdata->rg.bar,
+					  reg_off, reg_sz))
+		return -EINVAL;
+	pdata->rg.off = reg_off;
+	pdata->rg.sz = reg_sz;
+
+	entry_size = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_CH_ENTRY_SIZE, ctrl);
+	wr_table = PCI_EP_DMA_METADATA_HDR_LEN;
+	rd_table = PCI_EP_DMA_METADATA_HDR_LEN + wr_ch_cnt * entry_size;
+
+	ret = dw_edma_pcie_parse_ep_dma_ch_table(view, pdata, wr_table,
+						 entry_size, pdata->wr_ch_cnt,
+						 true);
+	if (ret)
+		return ret;
+
+	return dw_edma_pcie_parse_ep_dma_ch_table(view, pdata, rd_table,
+						  entry_size,
+						  pdata->rd_ch_cnt, false);
+}
+
+static int
+dw_edma_pcie_parse_ep_dma_caps(struct pci_dev *pdev,
+			       struct dw_edma_pcie_data *pdata)
+{
+	struct dw_edma_pcie_ep_dma_view metadata_view;
+	void __iomem *base;
+	resource_size_t bar_len;
+	enum pci_barno bar;
+	u32 ctrl;
+	int ret;
+
+	for (bar = BAR_0; bar < PCI_STD_NUM_BARS; bar++) {
+		if (!dw_edma_pcie_ep_dma_bar_scannable(pdev, bar))
+			continue;
+
+		bar_len = pci_resource_len(pdev, bar);
+		base = pci_iomap_range(pdev, bar, 0, 0);
+		if (!base)
+			continue;
+
+		metadata_view = (struct dw_edma_pcie_ep_dma_view) {
+			.pdev = pdev,
+			.base = base,
+			.limit = bar_len,
+		};
+		ret = dw_edma_pcie_validate_ep_dma_metadata(&metadata_view,
+							    NULL, NULL);
+		if (ret == -ENODEV) {
+			pci_iounmap(metadata_view.pdev, base);
+			continue;
+		}
+		if (ret) {
+			pci_iounmap(metadata_view.pdev, base);
+			return ret;
+		}
+
+		ctrl = dw_edma_pcie_ep_dma_readl(&metadata_view,
+						 PCI_EP_DMA_METADATA_CTRL);
+		ctrl |= PCI_EP_DMA_METADATA_CTRL_HOST_REQ;
+		dw_edma_pcie_ep_dma_writel(&metadata_view,
+					   PCI_EP_DMA_METADATA_CTRL, ctrl);
+
+		ret = dw_edma_pcie_ep_dma_wait_ready(&metadata_view);
+		if (ret) {
+			pci_iounmap(metadata_view.pdev, base);
+			return ret;
+		}
+
+		ret = dw_edma_pcie_parse_ep_dma_data(&metadata_view, pdata);
+		pci_iounmap(metadata_view.pdev, base);
+
+		return ret;
+	}
+
+	return -ENODEV;
+}
+
 static int
 dw_edma_pcie_parse_synopsys_caps(struct pci_dev *pdev,
 				 struct dw_edma_pcie_data *pdata)
@@ -354,6 +713,15 @@ dw_edma_pcie_parse_xilinx_caps(struct pci_dev *pdev,
 	return 0;
 }
 
+static const struct dw_edma_pcie_match_data ep_dma_match_data = {
+	.data = &ep_dma_data,
+	.plat_ops = &dw_edma_pcie_raw_addr_plat_ops,
+	.parse_caps = dw_edma_pcie_parse_ep_dma_caps,
+	.flags = DW_EDMA_PCIE_F_REG_OFFSET,
+	.chip_flags = DW_EDMA_CHIP_PARTIAL,
+	.default_irq_mode = DW_EDMA_CH_IRQ_REMOTE,
+};
+
 static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
 				 const struct dw_edma_pcie_match_data *match,
 				 struct dw_edma_pcie_data *pdata,
@@ -381,7 +749,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			      const struct pci_device_id *pid)
 {
 	const struct dw_edma_pcie_match_data *match = (void *)pid->driver_data;
-	const struct dw_edma_pcie_data *pdata = match->data;
+	const struct dw_edma_pcie_data *pdata;
 	struct device *dev = &pdev->dev;
 	struct dw_edma_chip *chip;
 	int err, nr_irqs;
@@ -394,6 +762,10 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		return err;
 	}
 
+	if (!match)
+		match = &ep_dma_match_data;
+	pdata = match->data;
+
 	struct dw_edma_pcie_data *dma_data __free(kfree) =
 		kmemdup(pdata, sizeof(*dma_data), GFP_KERNEL);
 	if (!dma_data)
-- 
2.51.0



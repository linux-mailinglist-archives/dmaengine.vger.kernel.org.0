Return-Path: <dmaengine+bounces-10610-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNdmCsWoDmpGBAYAu9opvQ
	(envelope-from <dmaengine+bounces-10610-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:40:05 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B6859F87D
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5998530598FC
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 06:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C971B142D;
	Thu, 21 May 2026 06:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="PJMqogCQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021086.outbound.protection.outlook.com [52.101.125.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A13221F20;
	Thu, 21 May 2026 06:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779345411; cv=fail; b=lwsqMWUicSJM+HFlHDH1PUo0LCSwzZ4pzP62yhwqBYrwjBHFhg8pV8OICN/LZ9vmwm/xp269uOposgGzXOgalXm0kvoZo+nkMoOv40GyVuZlJmSVFDwFJxOyM4y9q4MyLajsw4lnBSMmKd3HXN0KIFfC4dUxW49QBd430NkxGzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779345411; c=relaxed/simple;
	bh=FB+witlToWXxcpiezfExdkTW4NijAxT45BJfM3QyChM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uFzhMKhfUfWfFU7ENhlwbCpGiH5sOuA/09CbO3WwTDwzxAVOJ207E1zWNUJur7Dpg+A1hznp9pTVjNCgjaVsVQnGLZWhcPukDbTbMYqEPaBPS8HQ7UFAOIfeHgLURXey5I1A0UaeFgHcRbVq+hAxB9j1vJ9lzIHVlQpzukEuKDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=PJMqogCQ; arc=fail smtp.client-ip=52.101.125.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVD1KPIUHGN/xl3ONk7lm9qsQ5cwPejyuRRB1lKS4x/O+hfWqImdctur06++bS4rju9GRflAtCBdqI9S0qQ2kefpY7pcPkdwnLgh9w738CofVzRe/KA+vnWXSbSp/BS261FerORUUVkFalMZqbj07VVc0rltwK0D6syyl5QiH+YCPWXrUGINv3u269zzWBuQYWmbsZP5Ezn7M8Ty8fYDXSzhDYIrLC+6i0cfnSv+FuZkANw+DM1D77R6586bNPKMqfcvEamc9lLM2EcXnMvzt5zyDdmCFJz9fWZ+9jLPDSgERuZN+R816nuPsKhj8TqjMp5RuvhUtoI8Bp20MfHzMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dop1qI1keaJjQAunDvv5olkP8OB6yiyu1DY9uS5N5/Y=;
 b=cMQ+5b5oZ72eTwx1P4HVUHUxyBrBbbn3r0LSjth8yfOeOmNWPBDLH9oSZlK0n0znX1HXshCBdVO/n2rNeJEeLxhHmcsjqwOrtCWD/WfFTElYHWxnhq28ox8SNI3cHMT7I5QkYpL0jsGrP5AZ0kupxGWMxbdubTBVe6QycFjvH+0h5IgoDr35rWKpsqOsPcAlN8CUKCXa0ekiv+1GArhYYKo3e9n2qd9PCQi0FlOxMdbbapsEMOWpuolnm/o55tflXIY3nLjrHkx2hozQcGMyHHoaFtbsC8qx5rLiJhUr8EIvEVOMN/fjKERlu0xVpRPAFQg+g3BMKiSURPSAoJmIlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dop1qI1keaJjQAunDvv5olkP8OB6yiyu1DY9uS5N5/Y=;
 b=PJMqogCQfZ/hvuH9ExK08RwFVmyZgoD4qudHP6PyekHm+ES4T4Ldiw/dHkgUUk+nmTcoK3lQ8HjCFLIa+EBbx3DMod8sCxEiEbjkSLnTbP0D47MoCBQ/hnIiOOn+jTfusSO1n1hZ5vV/fW2bdEiyQyDDQz6OJJTbeVi2XBFP+Bg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7399.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:35c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Thu, 21 May
 2026 06:36:46 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 06:36:44 +0000
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
Subject: [PATCH 1/3] dmaengine: dw-edma-pcie: Discover endpoint DMA metadata
Date: Thu, 21 May 2026 15:36:36 +0900
Message-ID: <20260521063638.2843021-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260521063638.2843021-1-den@valinux.co.jp>
References: <20260521063638.2843021-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7399:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c96c2be-fc86-4447-bec0-08deb7035371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|7416014|366016|921020|18002099003|56012099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	VyPxx/zEGX+jXGQN1knC/4UohEnbowhFgsQXc878kY3AIqRiUawK91TmQc5XvYZ7vYlcKktcJDPBGZariHnIG0l6b9xwVyHR0cWr3JQ+Q3aKK+fymMSFOgTgWmhnRNrQd4DgxsjkV6CSHSOzbz18MthtG6H+QpRaXSg1QNRLCOMURKmzPIXHgAJeKXRM6BbsRuVsbKk3cNGCiERpaDysVvF9VLb/KIWZMVt9/r4UokWQGfeXNJae0bDf0hTs+hvxQ+epylONR8Do+7h7s5riekAylq6Cj8pjYoF0J81T95asAn6TAxUOood6yc/8fNHupfzQh4t076PCtaEnw79hSSQNMnyMIOLa1Pw+KSx6wT1q8RjmldHPi1Y4HZK3/grmNRkUvBp9Le4QNedq6mclu8rw4/ahicWMoPiFLf1Q42qHocWgVe3Arymohg2gTgsEeLHgWUdjrmqOzyFQfdDHk/AfO/d6hkIrAtZSG7q6ZIKjtRQF9eBF+cgaGDKIDRTwKLLS47KJpukHi0UIzxB4RWAl8e0T8nMPM50A7faf1T0xt6TG8qAJZMl9Z62jvN2gMbKvGgYKcXAxJBXc4pUg5RkYKF9KVbaP5QyDDpe1+3FO8sV4gdBL7zCAsEy4ooD+dRLaDdURZZnl1r2xtewAby8NxUh3usOoK9TgjZbLK8lCokV2iIPz2hK8FH6MFWlonWI5oiDJxs5OYr0YWacVLj8QrxbL1wXi93+YUihcZd8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(366016)(921020)(18002099003)(56012099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OQcZmX7EMWFpT7f5unYEAwdh001y1l7Cb3Rn3ytchL+Nlyk7ACQibPap+4lb?=
 =?us-ascii?Q?Nv8HDr2NSWPu8E8tJ3PY6UJ+Rr6KziO8Lvqw0X9HIWvaJkh+kLp1LcDgemOo?=
 =?us-ascii?Q?ry9VTs9pSZVezUQKgApr8YL/li9Jn1NFoJs4CUbmTzdV3CWNhd+WRH9HhLD6?=
 =?us-ascii?Q?pjtWKG6KpRYVt84ycDzQ4wPDGj3I2IrACA/wjLUOmJQNEKb78b8wsTw0Q/yJ?=
 =?us-ascii?Q?gLgcV9EFouzukk+5cIGrEyRZAUhCSPY26duDKpHPbHaUsktQV6o0D084jHxX?=
 =?us-ascii?Q?oE+TwiOpi9ICJnFBr3919oR1S4siBwUxKHn3w7+BISchms0TcdWjBUgaakg8?=
 =?us-ascii?Q?33oQRkndCJ3QjsxOjRZ6y2F1HOyLuZY7OdSSotoj1l459dQWvoJdy3acZetj?=
 =?us-ascii?Q?amxDtUGkg1TXz/iDyco4gi8dm2PA7DsbZk2yXMK8Wot0CZngquhPfTf5jbUk?=
 =?us-ascii?Q?8T4MV9uo8qJ40REdsffBeF7PKzL0DcratxhIe9a+ShKiJuJdp6qR/dZeWM0v?=
 =?us-ascii?Q?rZXcbj5hGsarvQ7mVywWxDnhIHTJTiryBgg48Tr7FsqrTWxcO0IOUD8AkQ2Q?=
 =?us-ascii?Q?WPcJeisZym5Lbi7PgJXmfHpZ8xy4RuIGTx5rcuMdnmSWUleKrWGZKRzqMRKx?=
 =?us-ascii?Q?BPCvieRQiw4AzYVT1iqgi+3E0rFvYKdjOmm8yA6Q+DoU4Ts3Py9Ic4Ovpads?=
 =?us-ascii?Q?uTC1fQDcHa0nNTs+VU4RrHHdplyNGfglDKWKKKpaezqBMRw+Iq5tl+9f6+jp?=
 =?us-ascii?Q?amQ73Y9XHPsJjRYeIjhGmY78eTbSE6e4V0mdYav3lRm2X07Lp7z5etjYBFAy?=
 =?us-ascii?Q?vKHqmtGnMGRNJ4/N/nOAbjcCVUXcX3JNMK7UhBSPyadFLW1bmH/WLuuuiT1x?=
 =?us-ascii?Q?0Dw+5i5Oy5eiXMuy/aYLZZD9o8bUnIp62gIA8zuFj6MsUqqRzdUC3xd3gtno?=
 =?us-ascii?Q?pR56Xqc4DZS7TclAKS+zRWGs5nFXKPAM8H0XyLTQaFJKAV18ZEpSIh8Ob5+1?=
 =?us-ascii?Q?caelWR68GDiDnh6tYUoU8VB0p/cb+84oq4JJAZxKZYURqzxJ3+SVoXsyea9R?=
 =?us-ascii?Q?HnsePimgEPTu4TKTwLOQ184dmmwHtbg208JN0Xd2Pl1zbQog1IfHXndxpupc?=
 =?us-ascii?Q?vbUWiX98RAwOYDuM7tZxioBJB7akKJ+yFQnCnxtVYQuH8rd5BFlqnk9uU6wQ?=
 =?us-ascii?Q?xjecKo8aRA2xtkLqY52ANmapy9KkMBiAU1YAtko68Da5qGLAGaI120dDEFhi?=
 =?us-ascii?Q?8bK2+jDoEA3lPz24AuL14AE5itDJA5A8RyoJQznNVuSQ9me2ElJbGPgTKMpL?=
 =?us-ascii?Q?V2l2zwXnkSlqT26vpTPfn2g8ROZUmpUmDBStvKnK70BjZNBzddUpNDm7A3df?=
 =?us-ascii?Q?5yODkZhNg8csDFAJFt6UTwJq3QmBsYcX7AJBpoct5xOm7XDihv8cME8SSCTA?=
 =?us-ascii?Q?GFLYDfZJyFeDpxn+knQsvrOacR6kxOqIXAk90uAJQawIujZodzpdg9BAw2cT?=
 =?us-ascii?Q?8hFOdJ/bqYHncQS4IqIiATnmhirwn21KXHWn2Rwki1JSTwT40T4yDX2KUEfx?=
 =?us-ascii?Q?bgID18rL7QvPGIF3JdmQN2UVpMF3JgEuBMXedGy0E1nsn9uliMQt1E8cYmO+?=
 =?us-ascii?Q?h7JFnuBM6w11WuBt59+DKZKlCNfQwwwigEq6Y6HjYxvuE96b2F51RYBUFjs3?=
 =?us-ascii?Q?ezqVYOpQZCOAlBymOzdOuzlUHJgbLfeanLKBPQnRK4TYTcT4mgnTt8CXN6uV?=
 =?us-ascii?Q?WglotSw8eLfIFwufEc3Ipz4ErjNfIyebqoY/BD9GqDzwM24IR8Yl?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c96c2be-fc86-4447-bec0-08deb7035371
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 06:36:44.7015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OIoEieaMFPoOrs4kRX6mNuSDt2MxKI+YLfnNn+CGRdCH8KKgEti+Nw4CUiS/fbe703ZfmTGAeH5p44zlS0ofvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7399
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10610-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: 94B6859F87D
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
 drivers/dma/dw-edma/dw-edma-pcie.c | 369 ++++++++++++++++++++++++++++-
 1 file changed, 368 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 2f752e8fb999..d4ae6df36858 100644
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
@@ -93,6 +100,12 @@ struct dw_edma_pcie_match_data {
 #define DW_EDMA_PCIE_F_RAW_SLAVE_ADDR	BIT(1)
 #define DW_EDMA_PCIE_F_REG_OFFSET	BIT(2)
 
+struct dw_edma_pcie_ep_dma_view {
+	struct pci_dev *pdev;
+	void __iomem *base;
+	resource_size_t limit;
+};
+
 static const struct dw_edma_pcie_data snps_edda_data = {
 	/* eDMA registers location */
 	.rg.bar				= BAR_0,
@@ -144,6 +157,13 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
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
@@ -217,6 +237,82 @@ static const struct dw_edma_plat_ops dw_edma_pcie_raw_addr_plat_ops = {
 	.irq_vector = dw_edma_pcie_irq_vector,
 };
 
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
@@ -318,6 +414,265 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
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
+			       struct dw_edma_pcie_data *pdata, bool *non_ll)
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
 				 struct dw_edma_pcie_data *pdata, bool *non_ll)
@@ -357,6 +712,14 @@ dw_edma_pcie_parse_xilinx_caps(struct pci_dev *pdev,
 	return 0;
 }
 
+static const struct dw_edma_pcie_match_data ep_dma_match_data = {
+	.data = &ep_dma_data,
+	.parse_caps = dw_edma_pcie_parse_ep_dma_caps,
+	.flags = DW_EDMA_PCIE_F_REG_OFFSET | DW_EDMA_PCIE_F_RAW_SLAVE_ADDR,
+	.chip_flags = DW_EDMA_CHIP_PARTIAL,
+	.default_irq_mode = DW_EDMA_CH_IRQ_REMOTE,
+};
+
 static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
 				 const struct dw_edma_pcie_match_data *match,
 				 struct dw_edma_pcie_data *pdata,
@@ -384,7 +747,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			      const struct pci_device_id *pid)
 {
 	const struct dw_edma_pcie_match_data *match = (void *)pid->driver_data;
-	const struct dw_edma_pcie_data *pdata = match->data;
+	const struct dw_edma_pcie_data *pdata;
 	struct device *dev = &pdev->dev;
 	struct dw_edma_chip *chip;
 	int err, nr_irqs;
@@ -398,6 +761,10 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
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



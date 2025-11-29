Return-Path: <dmaengine+bounces-7394-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DCDC9424D
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 17:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BA492348DED
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 16:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2772B3112B6;
	Sat, 29 Nov 2025 16:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="IOAHAGj4"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011070.outbound.protection.outlook.com [40.107.74.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CFE3101C4;
	Sat, 29 Nov 2025 16:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764432275; cv=fail; b=LJxBh/oO3d8T5lY7mOM/ys658c7ofBfNahvtm9/y7kINzqq/XBnRooRnPH8pDYn1loZkbjfsQhIiNUr42VK/0tOLaT9HFqu1Dh8BljABdLhS3QcjIhHs5Ae1bXigPrkyylgkIg/ZFngdtwN16ODim66ObFppq1SZjCdIs4RAksA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764432275; c=relaxed/simple;
	bh=MWApLqD4f8u7iEs3/UyJJ7ZW/qflz4ZEtoTREEceFto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T1aE/Oj1FQA3TRVt75blZ9naT8o5qju3InAXYYlqp654TT97aurimY4mCyE6AglVy/E7Pj6XGz0OYowzhPQE93J+7+Xfg6NfSWGS33polXp+quv5hiQg7NFCpzVl2G+LrUXrxhplzOE90zxXocvyWzPQPFPugq5k9YqxcpEydbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=IOAHAGj4; arc=fail smtp.client-ip=40.107.74.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mke+Fy6FmN6kqdB5ZRVZE5yecL9fJ1VgmR8zfw0kyKLNwn9uUT2u7l3Bh6HezCQyXDsKFp8wojLp5Mu0nj/HaYI4iAConhF7WAmGegnrhCwdoDXlnAb0YwfxmeLSzP62+f+7FnEqubOT2AvJlEEYJIBnP+29hrF9rVv/2ME0byG+hhbAygB7ZjNLc4Vgp8pMEbY5B+28yTwUQshFKI/OPT62wugyR/FHDr/EgEh4aRloMpq62KKhWVM1dlMTun2JoSM708gOosou+x0QXXTnaYe/XiXD1NNeOhJmr0wOUQXRcQysvNxhm3RWTg/nnpGiGODtH8xyu3QNwxkMhCIi9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvywiF7A/J6u/C0VKVz/MyeKxEHR5eMLNrym9BVeHxQ=;
 b=IXTm03Zouddslt/cXKImD81dPx7TPb/pBqQlls7q3qeDwsS20jdg3/FcDgRjZDQi1GHFvL0z3x5s93/FohaUGo98uh6o8D+kdkU05Jis3D7CvxnfT7DJ796ERaVOek1Df4IdpCG5QbHJBslKUkM/FNHOv96WFukQQ07CvUzElCLss12jZS2rnhlOj4wrgEenV/AhEt1d/0pGdUO46NHSBlCPb4zeKQ0n0pF5xQnV2GAvbriDvKSH846UBQCExRB4LRQkarzVr8nw54L+yfF9OCkuwTt37nUb/7jEkZ6lHWKgEroaowx7XoDZ4VixHlMDWuHMrEZ7byJvfu5Bfey+yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvywiF7A/J6u/C0VKVz/MyeKxEHR5eMLNrym9BVeHxQ=;
 b=IOAHAGj4MACNq03rIhom5o0pIiUxBDmlovV7R2o672e61YuLUL0qWZYEHJ/e6PEs9Xxjc+wljAG9hol/WItgwJQYmTyMzi8qdl/8SKFRVRp+H/O16rRHbDm8AS1ZamZC3kjqzu4ovMmwMxuEcfFHZ1G5nidgwqVIch8p40cXHOw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYCP286MB2050.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sat, 29 Nov
 2025 16:04:27 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Sat, 29 Nov 2025
 16:04:27 +0000
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
Subject: [RFC PATCH v2 09/27] NTB: ntb_transport: Support offsetted partial memory windows
Date: Sun, 30 Nov 2025 01:03:47 +0900
Message-ID: <20251129160405.2568284-10-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251129160405.2568284-1-den@valinux.co.jp>
References: <20251129160405.2568284-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0057.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::20) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYCP286MB2050:EE_
X-MS-Office365-Filtering-Correlation-Id: da02b3dc-6812-4d6a-c5a2-08de2f60f8ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O0K6HrQ2b4GeMftjPN1MxYa5hdmXgmuRP7wjI6rVrgKSeBmBsyOeKGDKOkYv?=
 =?us-ascii?Q?rzq1EB01IodsKirGF8LI5VNMPeUOpikIfOY/dK0JUHagJsDeptbgo76JyCUq?=
 =?us-ascii?Q?iCrOzV5TAXj3MLdrekS9Dxlgdum8p1M3zEyDfBi+0gwVHKzvD/s/34FV9V1U?=
 =?us-ascii?Q?o59Z3D6W8qqv/MLMMDLiW2cmF84kPlRYTX9PTQkovbG+y2Pvn7rSPXNhTQLZ?=
 =?us-ascii?Q?/xlLplqXnWndiwyltxONAEbnN4WOMm6YxMikK56zw9stJYSWOboySmLjd4u8?=
 =?us-ascii?Q?bQDCmA7YV3HFL0lZu45z31URCnUSTpwaGAVJMrNw1Z7PmnKtZa0THtbooziw?=
 =?us-ascii?Q?u0hbnq9Lhy37+5CeNwx5/fCIRjXsrha/gxh4AxVKgsijoNBNDGru2HbUvZuU?=
 =?us-ascii?Q?joiKWLVQhki2jCOKdyLRbIMOkNsqGm+y5QnjehrrFSv4HV6AG3dQ8+41aQYO?=
 =?us-ascii?Q?rlmfUe3Kn09tGfaLd0Yhmr6MMO9uuT2CnUHWQkMhB8nVKjD41jK912EXZDPG?=
 =?us-ascii?Q?nUHcfQ1sKJ10LIlAonJdjyRprE80WNvSZss221fvDvjxri5S9r8QETfjvCg0?=
 =?us-ascii?Q?u4JiF5UtPcQYkQ3ghOkIEbRfmQIsCRR8sEHEmDZWGgZt9mv089pJ+gLgXHfJ?=
 =?us-ascii?Q?qOwS8VPrIkfLWK1+TnAzn9j+rVYkaRXICVx9lQbBh2wAxLVk6tCuaVb6c3dT?=
 =?us-ascii?Q?TQiH20g/U4LaP0wX1siOGZF2R5tNprXp6koIC9XKKxLJvF2K0xPiQ0/BnS56?=
 =?us-ascii?Q?MwlQobr2yekxmEe5T+vy0e1Lzl+9WEA1MgWas6weEyLOVsNu4O7XSxXdURWt?=
 =?us-ascii?Q?PcrqlDgaQ6abcpWQhQpUKbNmRkUMAvCgPXTkLtk7UXGG5oNVNmXOuVBUyad1?=
 =?us-ascii?Q?N7S9X5PBqAumlrnjvLkdC7bjlGb3ULI2r5w1j/2STm6v4HPwCzJGpjkZdTII?=
 =?us-ascii?Q?wfTAPGEtYXz23uGKwZQWyJheZ8FA1XI2+aGub1X/tlI7xZ8rIE9DVqj8Gsm8?=
 =?us-ascii?Q?3xdUcmsUFthBnUjGpw1IcN4RNrCdPfKCuB247mddjCmnG1eymw1AzMCECJzS?=
 =?us-ascii?Q?KKcW8s2RTQrvym3FWuncfX4nLYKgURlGPGQJAHMrRFgGeBHv5lHZROzAx8xF?=
 =?us-ascii?Q?LMCRd2h4qVtZ3/Bqe7UBkXJsva1MnrJj3aaT4hl4ZUTB7lIb08JVULEAlI1V?=
 =?us-ascii?Q?wYV3ReJyCxTsQI5x4i3Fh4gNcKPuPU8ZtfdeNyXHJMOphhdLTq7Hw/aby86T?=
 =?us-ascii?Q?fifir7NmfMhZ8SQ0wg/yxm7bn47w0t1iPgqc+FDxOG6dVqliluAJp7Ka16KK?=
 =?us-ascii?Q?vc1d58eJb4hVwYsSRWg1CZdMbqSjaffaX4rkb2hSJ9R1WBV3A9YQ8SuESTh/?=
 =?us-ascii?Q?/is3J/tlbEvt7KrkXI2UyzbLyzCIWIZGxQUW18ekuS41Mkqb8x73hxAPW9tv?=
 =?us-ascii?Q?+gM8P3oPuSBFzuUMvmMmM7MYxi7HQ5Ka?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c3+u3pe1BTgBQhY2zLadInPQidsCMCoE6iTW+Xx8t78HfhhZ15HN/UeniCl4?=
 =?us-ascii?Q?2HRDN76qMS8AFrA2Sqy6fR6IJBFkI5bwr3vdSRT5nPZaiic7wJ+pgIn6DxIO?=
 =?us-ascii?Q?z0n/V8jD5D3dWSS5DzaQWF5BEGXitJCF0SOc5p+Yqd6UWsWsnxVaRs+V2I91?=
 =?us-ascii?Q?D6elxCxUyVURRYOvlcnG/OQgjFYX3TX4GoUZoIxwBThrBxSDoszhNixvuQ1L?=
 =?us-ascii?Q?Z5JIl2rKnUdZ+2qUHysL8lsqQFa9TUXl99kbcvpOYo7h7YSeBptR4LVxyFqv?=
 =?us-ascii?Q?cYs4l3XykFJDQ1h2S3Te+0pZV4V1t61QBouTWs5XC472pICQXq16xVytBgoN?=
 =?us-ascii?Q?I5IEw64LdaPiikYYG4wsksSaC9QDOaEKiVbOWuW9HWaykG/USo2k2y7au8iC?=
 =?us-ascii?Q?T+T9TwE2EP/N2DH2YgmTJTkrTgGVAgGMny5f159YRWxjo1LAUvembFIHjOxy?=
 =?us-ascii?Q?IJyKO8HSRKj/oDNmyfzvWCnzbp/4qN4EcaCzchLnAFSLc9nZfTW8ZQsxMghy?=
 =?us-ascii?Q?Xw3xZ+yqn6yNFV8m9NVbK4vvdCkydCtFp2bsDvUzllY4L4BOJMg4mo6B4BRy?=
 =?us-ascii?Q?P29W4eOtC/WI9mrYgERZqPrcBc73WbcgX+JMmFrdT16/tZHv6rg5cyWoe3WN?=
 =?us-ascii?Q?kZ1T2liCSg6cQ2meP2bYXYjR8UT21dhf/7/nYz9iMOEcHdzkHEf1DZXnpxpJ?=
 =?us-ascii?Q?LmNNE51oKt3Z2a2Bm37I3QmnQFQosD6Nuy5u2yJXysug3afWSljfPn+T0SHP?=
 =?us-ascii?Q?4WaXn0UqpDCJHkjGHi+Z6gdA/+PYqsnl8Rel1/jnbG0DB0dQeHVFDgYl8NQf?=
 =?us-ascii?Q?QCL+CTcXKWbIPDnfj4Z1CXrr/5Ey46dHF23ohjCR2bveF/wlz0/FExNhxY89?=
 =?us-ascii?Q?c/MemK1Qz1gytYtNBkhGxFdwnKJgc0zlQAgqG+EpHTO/Y84MeKmIYMrJ51PF?=
 =?us-ascii?Q?L4HSAMAxSkxrSOsH93OcAt7kUp4UkeJP5ky1g9dXlXPFVnsPASJKmfUjNPUO?=
 =?us-ascii?Q?g5i6zu5pZxuLepA3DCbbrECM2p5NjBh2C7tzzZIfGNzwdYmPxiayuZpbkfMC?=
 =?us-ascii?Q?aJL4mON/xh2iVEgKvX0hKDCkq2TBN2XTyIe0Opwb4qZH8B3ZmjkgIE7zRBiD?=
 =?us-ascii?Q?+AEHpfaYyACGKU1CLevzEAPT3F7Nrgntabq91Rd31LEt7DCHIORL5Gl8b8jn?=
 =?us-ascii?Q?T6JawVt1XX6t7Rzp2+JKWwgs8zmsQHma7Mymc6ovP8YOhi1B+oJCQ9Uq7bRM?=
 =?us-ascii?Q?CeCVr1NLyUDBEHNMxL+Pu57ehFVA+N/byhSjcH+4x7L8rzQiPjFfNn397iws?=
 =?us-ascii?Q?DhrXMm0Guw1lEmVS0QXEIVB4j5z3R+DAPz+Nyz9nY3nPtmWGqqoLNB3CLDB3?=
 =?us-ascii?Q?+TMf2YXPO5k/q06hUYLuy8+VvsSTtMHThU6CR9Gw3lFOMHXrKykJlpJvxfso?=
 =?us-ascii?Q?waZGdKhh5GDftADQfwttEBadv0w5t/hEq9a6MWu6TGAXvR1hJJ1uSU7lomIP?=
 =?us-ascii?Q?PfLeSasjp9EsDhiVoyrkH2Y8EquOElZVpFFGQyZL+bLLFaSTxE8vOJgfAOkk?=
 =?us-ascii?Q?sJOczAysYCzhqRJBAVMkuOOxFKKwgcjqRkKoBHaBY2R7w+xCxT5eSasU6tGf?=
 =?us-ascii?Q?h9m8oe0i/H3r9CRsqH6G9I8=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: da02b3dc-6812-4d6a-c5a2-08de2f60f8ec
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2025 16:04:27.3583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VfjQOIz8JEZp8isrvyfsLtvegVL5STKAYF8hgSScQjpNrnZcKfyY+kMkq9oBkB8Mw22oOSSwtso/DevxV0C9bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2050

The NTB API functions ntb_mw_set_trans() and ntb_mw_get_align() now
support non-zero MW offsets. Update ntb_transport to make use of this
capability by propagating the offset when setting up MW translations.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 4bb1a64c1090..3f3bc991e667 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -877,13 +877,14 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 	size_t xlat_size, buff_size;
 	resource_size_t xlat_align;
 	resource_size_t xlat_align_size;
+	resource_size_t offset;
 	int rc;
 
 	if (!size)
 		return -EINVAL;
 
 	rc = ntb_mw_get_align(nt->ndev, PIDX, num_mw, &xlat_align,
-			      &xlat_align_size, NULL, NULL);
+			      &xlat_align_size, NULL, &offset);
 	if (rc)
 		return rc;
 
@@ -918,7 +919,7 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 
 	/* Notify HW the memory location of the receive buffer */
 	rc = ntb_mw_set_trans(nt->ndev, PIDX, num_mw, mw->dma_addr,
-			      mw->xlat_size, 0);
+			      mw->xlat_size, offset);
 	if (rc) {
 		dev_err(&pdev->dev, "Unable to set mw%d translation", num_mw);
 		ntb_free_mw(nt, num_mw);
-- 
2.48.1



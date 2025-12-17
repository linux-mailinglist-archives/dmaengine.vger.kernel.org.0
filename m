Return-Path: <dmaengine+bounces-7774-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E84EDCC890F
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 16:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBB09300AB0C
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 15:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC9D361DA0;
	Wed, 17 Dec 2025 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="U6lkX6n3"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010020.outbound.protection.outlook.com [52.101.228.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBC235CBD5;
	Wed, 17 Dec 2025 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765984668; cv=fail; b=sSYBGF9fmfL+LU4pLcNfRdonjjN4U4HbYGa9MjgrYSWXIoV+HCd6SKMP4nnt9nBNp28BQQO6kNKPfUhZ5KhxaI7IXZMsU02xz5Gb02CVUXM2TOHswywAJGcw7UCOie+7ktDr14RsMeyIDa/xn/+5DD1Zdxytmigsfp5S9ucAdjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765984668; c=relaxed/simple;
	bh=1Y9bU92YdEUA/d81fMwuTKdzIC3gHlad9y6sgvRh99A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sgG9EFjM7p95/gM+74FIN0D5r0yCXXAE+OJMojqCE5K9xCzqBVjUbRveoObyUoCSmbSzLHo//R4ny1y/JcMhfBWf9z9fBY53PGZUweNBSQjHbo7cHHWRYACpZOxxR6wahCHDPkw2cVpL22G+A71tZ6aXhuKkydc0Todlqc6GijQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=U6lkX6n3; arc=fail smtp.client-ip=52.101.228.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vd0UONTDQ4BaW6fSB9nnnugAV+GPq8lJ6IDqx6OGbh2MTgT1Bwiu+HLkHLxiqux0VmCnrCKIIX8CocuFmWX0ltV5jKCDWhVdrq6y9DiSjjljTKNRmH8DFjSOQAk03cpCIk5rH+LcOUF54rvvKvt3WaTvysf5emn+JnRVrX7dIb2xAbm35b5B/cozKTMteWqMXywjLZyrK8kTnUJ+tOEA72cLDelqlB6FHobD8zp9rtLRF9BxFgPfBtYdG4RhpAeO4aLtcvG6MjAc2ShMEr7vf7W4jCI14eNiT8NHZb2Pc7uMTJNsxDdKd5FNxpsY/VLk+PGXs46mp1AAu0KzYscxUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBHhV8flWb08jkfgSrsYDEjcKE4stA0DKcw1IQNChX8=;
 b=QMS7UAWHmbfHjHBOjUPXu+SCmfWMIa21li9O4YOY+ccMURjj8Imi4iqkVYVgOua+9K0koRanhzF1wDiuG2aI39HL0neneUGpI61Tijy4rto4Yt4rDqc70tKF4RJkWtYVXsvZnDbzfpQ3UHUqBtYuaXQaws/F1Ru58OgMPdrK7WKZ+nTNm1NElJyoZUntF/2RU29LfIw2FKrNzo22XvWbWUr+u5ElDbDHUt/tQQvhJh8aeqbB7UJtQqxWVjrX4rtG4MFbaKVTwvnznO6RSf0qZiAudFXDyBAZLPlofe+qWVlbUNz3ys5lbW7UHBO8zq4AB0LveiGfxe9p/GhBmfIZ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBHhV8flWb08jkfgSrsYDEjcKE4stA0DKcw1IQNChX8=;
 b=U6lkX6n3xMtDG1BIz4td3w98KjelghQqPwv/zKoXJcwETn5DHcxnF1zOawyjojTOqfaX+1rfdMgo9FupxtVfi846/jFTo9OaLWrEh369dSf7P4pkood9YeSwS3q8cTLX75lSwQRht2CuoL54KAIYuo377ie6TQbxfI+5tjmDlJk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYCP286MB2863.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:306::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:16:31 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:16:31 +0000
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
Subject: [RFC PATCH v3 20/35] dmaengine: dw-edma: Add notify-only channels support
Date: Thu, 18 Dec 2025 00:15:54 +0900
Message-ID: <20251217151609.3162665-21-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251217151609.3162665-1-den@valinux.co.jp>
References: <20251217151609.3162665-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0119.jpnprd01.prod.outlook.com
 (2603:1096:405:4::35) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYCP286MB2863:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b848c19-2894-4397-792c-08de3d7f4249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sLG43AwZPQPuvufAMICIVDhtA8iR+tcq8JAZjDcin8dEIopfQRAohtEgdg7H?=
 =?us-ascii?Q?OiC8UmIJB3BeMgFg299O5DpQW2Y9ws/6VGBLERC4hxfbeHWoYooBw0j4Ij9y?=
 =?us-ascii?Q?X2AFBjdv/LsXz7bH0645pnbcOUNmYsdl7CKFHcijxXPIOxoliM+L+dKZXFCL?=
 =?us-ascii?Q?I+l1lw07x0ds/2U3TwZMyP15VGd4oPB6nDurOPWVukT8upnSHlkmsFW1ZUxA?=
 =?us-ascii?Q?l7FR+a1tGy/ztC5x78mInDDBxnFlh0IKvh4K1fdVyWJjE32VacZY4vpQGIeo?=
 =?us-ascii?Q?gJ/Fy16xKMwBpYeH+z5q65CNilJw3CuCFJCAfzG4y+j49I5q+E9jexOeVWfz?=
 =?us-ascii?Q?YTTlwmeAsLFV49fODXV567nWVSbthuWot9NKJKW1f15xWyzJ1dkZ5qzxpLTo?=
 =?us-ascii?Q?3rXeOU/+MxLINKHmVq0i3DMvWvHwUPtf/M67AyT7VCDLivbsDu3uq7J8X4Z/?=
 =?us-ascii?Q?tUTB+IdHQj6MStkVTKra7VKF01EF1enpeXeTJy0CN6rsz68kZ4oLF0Kk5YtI?=
 =?us-ascii?Q?K3p0XfNHZQJjDAAFzDfhY708TwoKd7NC9dZDK9IZ8R6ziyHkfVWiHumQW2wz?=
 =?us-ascii?Q?zVQMMqUaj1ll/ag5KHqeyb0d7meHxNbFv8TtyP2f+JPaSmV0O0+2WyyzSB9b?=
 =?us-ascii?Q?TthNYia7WSa2jWk6/5Wp8IdymSMLhrhQO/98xs4xuakt5nTQJn84ybLlXV8V?=
 =?us-ascii?Q?+n2lTrqW0CL3PTuV7V6sToNBY3OJ7Gms0LLezTYe2bJTsH7iv8d9og2vqDdD?=
 =?us-ascii?Q?UHL9tV4YRTGZiUfJUSX/v5aGK6Bk0btRHnOW83Rq1lfncczctQVyIxpZ6E9N?=
 =?us-ascii?Q?Jio2hdshgsr6S2W0VM9zafx+Lu/pWRmMwSmNFGlbJAgvjRt6rT3YT73JaTz/?=
 =?us-ascii?Q?uYw4okecCV5QZdeY+SHwNjKyB+G8rPVAPGaTUQYEx5J4ucifrhuZidDGO5GU?=
 =?us-ascii?Q?OSICO70W6AA9BQjMQsYjDf8YZkK7dbadgoVOArGmvlcJg36Xmq7wdQTeMRKY?=
 =?us-ascii?Q?5MZqcSGaa7YNic5ZWrQq/L0FOHJuPTTJqX9aiPol7F/PyTdrRn28BNaxFtav?=
 =?us-ascii?Q?4kHeq1MAN3dWuQ+YpuKIGuEbyjCCaXg3XcT/W9DT9O9LEYVnzg0BY4cR0uKv?=
 =?us-ascii?Q?RyQ9IJWQHGSW19by+cZXnj+9ed45f0xHdDuc7u3dZx917CQlLHYyzhgm57mj?=
 =?us-ascii?Q?RHXCoe0s9TkTW7+zm2Z4G7CzMS+c3NYeXN6YNOIySM3K0iOKtgBPvlBQQZqd?=
 =?us-ascii?Q?4GyqDUmbe5FFJyxeRid9/kZmvKCdsAH2hUND2SyijHdzxC/+vxL3USI+bvy1?=
 =?us-ascii?Q?bimcv/wWDCGsFORRonHH43hPcmyY1qaLKcPt5wOE7TCBJxqFmDz5Jil9Me6K?=
 =?us-ascii?Q?stpMAobCNskyP18BM6enUhvt9e/aALrosPtOxF219dIVsSnH4LyluzZyZ7fj?=
 =?us-ascii?Q?iQvE7rHejwLjubclmc1TFLG/v1UVxz6b?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TCzE4IQEv8z7TILvR7w2acsGkwtyUpJLMyNh/Wqhpbb/D3Y1jNP3HHf29HzZ?=
 =?us-ascii?Q?V6/TrLFHn9uxCbafnWlew7WfstugtoGby0pKdLo9CIikcuEmZOofjhVwYAWz?=
 =?us-ascii?Q?0xnG23ud88JEBTlAR/hogEdqLulltRA6r5Wxv/+G5oYIX056osoNAiK0D0ER?=
 =?us-ascii?Q?MFAy0Xr4FV0monTC93wqOYTNs25Oqh5Xb04StzpYZBFUbghQe2NyPf5I7p7U?=
 =?us-ascii?Q?mUXKRxOC0DzBwy618EHQ3gyWjY9QvZ2L7aqvQ8lHDTumHxTnGg7dYxrCqIv4?=
 =?us-ascii?Q?cXpQ10M1U3aSob4we/nt5s2EoIQe7lclGu+ZUesM783QNu8M6bVqT38no1B9?=
 =?us-ascii?Q?He7cWp5THiKvf6PcVYq5uiQKYOmHH9H2RjNaI2YKbaufkllWpQvy46qhoq9S?=
 =?us-ascii?Q?roq9K2Nhe8i9161MlAqfDo5qFHvWMcAJbj3UlCtlecIPK09cGj65tKtygKN9?=
 =?us-ascii?Q?mPOHhm9vxDTtMN02zSIRDb2uXdwIHKkFcz2JsSwWN2IxxYtH3lmuaxPw2fsb?=
 =?us-ascii?Q?ZF47chqE74y6+tN1at6k5NiRqXD3cDZxgAqIVaWkrq5+1JDZoR32jkMG3tM8?=
 =?us-ascii?Q?HTRrjnMnjeIjw8k0ovXFTMz+5SG3f0/JdCYbG2Z4gaYucuIyF33+ehCj7Bty?=
 =?us-ascii?Q?oRF0wWZyQUtkhx6tn4KVx3Ac7QQpLxVEmsgPFiEwOF64m/gNaHSxf+UVvyu7?=
 =?us-ascii?Q?nhOl9Z1CgaZmBHSb640GRd+8NAHtUENCR7iDcC+pDzXVJq4R5VybYQV7o+Yw?=
 =?us-ascii?Q?wxnOXGJw1TrMdk1V6GLILDlVmbTEOpUiS14ssrMBhGCwqhMFYKL++EwxDzy4?=
 =?us-ascii?Q?eowv94JcsCOB7xNqDwQ5YhqIxGRCFvbWr8hMcbjwXYwVKUe3Hg9q37WKt8u9?=
 =?us-ascii?Q?ijkPhCLQcdaOZxu0o6fchZwCzHtWHYYB+/ZDtkvorU97n225yti5bfY72uUK?=
 =?us-ascii?Q?I1mYmjoyxRXnDTNsLNLVEd2iE8btU1dJPfz43Ee/0GOac/8Ae5zDnfIozxRo?=
 =?us-ascii?Q?l25BPlWWrjMXKdzCVcTYGdtRjjsFPEdVF4VWLroHE35cjoEIQN9SPS+LRzkQ?=
 =?us-ascii?Q?ocBDXCaV+n3wM0o8YkAl2YZqfDrKnGSYJjlIdV7eXENHb0zwXda2f7ZwNZo7?=
 =?us-ascii?Q?RfnUNP4Te6Xe+z689ArWsedp7AsjPu9ZDoERPhvGakuqPYeYyPJIjtNzEpWE?=
 =?us-ascii?Q?j5d/cPafXTMvkUtaGTOs6z2sPxhjdhzZ1PxVPdym+OZr07g/V/lvQiwU2DAC?=
 =?us-ascii?Q?jOQrMkaZ8DdEuNdjfynzUWsDtWnuVBFBT5kq0hknWswxmPWNQLVmiDkPp2p4?=
 =?us-ascii?Q?2bxQjUnrDTo6kzk9suDlIFAqoz/vTw0X0Cy8GCrDLCPCGrSeIqRAwgRIzysI?=
 =?us-ascii?Q?GkqVecOybhdwVjFsMHbeXJYYX8rpSynPcRJcqZMbrbPYKenRoTyIGOHO8cMq?=
 =?us-ascii?Q?F6MvH3yqSkAeGVXoVRNS0bkC31XT9uT8PrbBA17AsEbhYlfDTq03vq26qZkw?=
 =?us-ascii?Q?0zuJxTzqGYG06Bva/63S9AqJja88WCRLSEeH/nIk4YL4agJ0slE1ky2rISLq?=
 =?us-ascii?Q?qirJrOd21azKN2TtxnnFYLZS56ilHM3K2Wa0ihElqdkHxbh86HYc3mLhfZA8?=
 =?us-ascii?Q?LVcloDpRoq0y0jsNEW3q+7E=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b848c19-2894-4397-792c-08de3d7f4249
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:16:31.6140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2cgrHeotYXTbPDtpiFU54i+YqoA87nMT3B45UosmgeROQ9vzpbLXvLKEuShFuhyh3nlh9aI+nfHyXF0yQU3xnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2863

Remote eDMA users may want to prepare descriptors on the remote side while
the local side only needs completion notifications (no cookie-based
accounting).

Provide a lightweight per-channel notification callback infrastructure.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c | 32 ++++++++++++++++++++++++++++++
 drivers/dma/dw-edma/dw-edma-core.h |  4 ++++
 include/linux/dma/edma.h           | 22 ++++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 09b10ad1f38a..8e262f61f02d 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -608,6 +608,13 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 	struct virt_dma_desc *vd;
 	unsigned long flags;
 
+	if (chan->notify_only) {
+		if (chan->notify_cb)
+			chan->notify_cb(&chan->vc.chan, chan->notify_cb_param);
+		/* no cookie on this side, just return */
+		return;
+	}
+
 	spin_lock_irqsave(&chan->vc.lock, flags);
 	vd = vchan_next_desc(&chan->vc);
 	if (vd) {
@@ -811,6 +818,9 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 		chan->request = EDMA_REQ_NONE;
 		chan->status = EDMA_ST_IDLE;
 		chan->irq_mode = DW_EDMA_CH_IRQ_DEFAULT;
+		chan->notify_cb = NULL;
+		chan->notify_cb_param = NULL;
+		chan->notify_only = false;
 
 		if (chan->dir == EDMA_DIR_WRITE)
 			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
@@ -1171,6 +1181,28 @@ bool dw_edma_chan_ignore_irq(struct dma_chan *dchan)
 }
 EXPORT_SYMBOL_GPL(dw_edma_chan_ignore_irq);
 
+int dw_edma_chan_register_notify(struct dma_chan *dchan,
+				 void (*cb)(struct dma_chan *chan, void *user),
+				 void *user)
+{
+	struct dw_edma_chan *chan;
+
+	if (!dchan || !dchan->device ||
+	    dchan->device->device_prep_slave_sg_config != dw_edma_device_prep_slave_sg_config)
+		return -ENODEV;
+
+	chan = dchan2dw_edma_chan(dchan);
+	if (!chan)
+		return -ENODEV;
+
+	chan->notify_cb = cb;
+	chan->notify_cb_param = user;
+	chan->notify_only = !!cb;
+
+	return dw_edma_chan_irq_config(dchan, DW_EDMA_CH_IRQ_LOCAL);
+}
+EXPORT_SYMBOL_GPL(dw_edma_chan_register_notify);
+
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
 MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 11fe4532f0bf..f652d2e38843 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -84,6 +84,10 @@ struct dw_edma_chan {
 
 	enum dw_edma_ch_irq_mode	irq_mode;
 
+	void (*notify_cb)(struct dma_chan *chan, void *user);
+	void *notify_cb_param;
+	bool notify_only;
+
 	struct delayed_work		poll_work;
 	spinlock_t			poll_lock;
 
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 8c1b1d25fa44..4caf5cc5c368 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -95,6 +95,21 @@ int dw_edma_chan_irq_config(struct dma_chan *chan,
  */
 bool dw_edma_chan_ignore_irq(struct dma_chan *chan);
 
+/**
+ * dw_edma_chan_register_notify - register local completion callback for a
+ *                                notification-only channel
+ * @chan: DMA channel obtained from dma_request_channel()
+ * @cb:   callback invoked in hardirq context when LIE interrupt is raised
+ * @user: opaque pointer passed back to @cb
+ *
+ * Intended for channels where descriptors are prepared on the remote side and
+ * the local side only wants completion notifications. This forces LOCAL mode
+ * so that the local side receives LIE interrupts.
+ */
+int dw_edma_chan_register_notify(struct dma_chan *chan,
+				 void (*cb)(struct dma_chan *chan, void *user),
+				 void *user);
+
 #if IS_REACHABLE(CONFIG_PCIE_DW)
 /**
  * dw_edma_get_reg_window - get eDMA register base and size
@@ -185,6 +200,13 @@ static inline bool dw_edma_chan_ignore_irq(struct dma_chan *chan)
 {
 	return false;
 }
+static inline int dw_edma_chan_register_notify(struct dma_chan *chan,
+					       void (*cb)(struct dma_chan *chan,
+							  void *user),
+					       void *user)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* _DW_EDMA_H */
-- 
2.51.0



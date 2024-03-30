Return-Path: <dmaengine+bounces-1671-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C07B7892BD0
	for <lists+dmaengine@lfdr.de>; Sat, 30 Mar 2024 16:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C990B215AE
	for <lists+dmaengine@lfdr.de>; Sat, 30 Mar 2024 15:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978D6381CC;
	Sat, 30 Mar 2024 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hapkq9M1"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2070.outbound.protection.outlook.com [40.92.59.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F3A1C0DEF;
	Sat, 30 Mar 2024 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.59.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711812243; cv=fail; b=rAw2OeXxwinhOCVzltCdtRN/kho2JXcW0R7CJVu6VGYW8sdYtYLXapXQvQyfkchubXmxdJxbYz8Nv0FBEQ2zjWfvztAcLVnli0Ce7TK3AhGCKXbcYWCgIkfWZcXU2x9LDmdkKgm4DSWl31HZtdqgrqnlAarnW6Dq3deRYQly8fA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711812243; c=relaxed/simple;
	bh=mgOyeD9piZnUBQpAOdgX6Pv0wnCmVXamNecDH+ZfGGA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QOHhe40T8ZgN26Ev226ah+iC5fxpRof+jDgew1FZfLL0Aqpj5MlnhiGnoHtJN3RKyKfOO2Zit9LzvQbRxq8wBObUn3ep+48IUOgnY10k9kJbBuQDeE91O8vustGm+Zsk0nUFssng7vr5toimkz6GieY+fpYbbrW0Xe2Z28MjPpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hapkq9M1; arc=fail smtp.client-ip=40.92.59.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kj/ZaovklV1aZ9gLY/T6FUzp/GLYrz9nqvtVe6CWX1j/idoavn/tvQ8MAsuSMCANHE9DKrkDtFEFJIZYvA/MbY2CBrmPeuPfYa+QxtiP8hRXISZCNF18qw6GHpTqWRf1zlqy6ya5gZGvyQO2yhOvsne/h9D2Gom7jVuwPSmNQcEyUefw6nRd3flSsM+v/+sUmR2xACLe11V88z/xamELXpvGgLa9z3tu8EjlYwFKMHPWpo98WSUEQUHEW6cwB5+81ngplSOlz82JNuhTgVmvjiVt038qgBjOFG2LABSOPltaTEdMuNz1Weo/COQb1XAnChorr7vIGlpAi1JmakrWNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFOsPr1VrjllHTP4jRfLDiW2C4PsBe9dz1I3i5L7he0=;
 b=oI32ae/W2P7eK6/UkT+LqXmz8W72VjsDnYyYiDrTPvzY3USLUrJAKw3W7KJJx9p0soiNuqrUsSx90SzjAinKaKIp+waJ5n5bj4/DRRM+ZLXI17dyFsb++JAHZ5q/4HsT+cDAyGlA32xxIODp9NOUIaZxGOCpadrpOtj/JYOjg9e1WotwpLa77yh/Xk/EtI4q2SnDMEgALzw2AvYtjVM/xIsiggAVb+zLhrng+s65ixyegDHPN51c0zRFyjFjIlJfVLwSj5pb/0Q4jkDZb3J4KIr9uNW2OC5s/3B2kd7a0z3poeZPpirzh4FNy0+UZPfLhcySHW5Y8VeUFF2wJj14lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFOsPr1VrjllHTP4jRfLDiW2C4PsBe9dz1I3i5L7he0=;
 b=hapkq9M1Dy63rdLywPrRJmkYVhigaWAC7Q26yAo4V01SEQMZi5TaZYGZGM0G6P5o2AAzfKVunK90RkthPMMyEnoFRnkMFHV3l3R04ITOgFkC5EW6muNivLKxUkpgvyEvl/qOBc2YOvoL/fVfpt5pvShWpANR4l5p1X7QWbTJRIfGPGNWtZStmz+ETpFUR3DSSla3Rl8bkdwHIZUN96wV9RR1uu6zOGQHhkucuhtoOv6YbOGoVsd/mfQ76YJz65iTZ0FV0gaeArLT3t9C457GhOncerpVlqzsUVByMsqzyD9yqwrngYUkrrmmKAWCk/tKGB40xtwGzhxfKVS5aAc7Mg==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by AS2PR02MB9882.eurprd02.prod.outlook.com (2603:10a6:20b:60a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.42; Sat, 30 Mar
 2024 15:23:58 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::9817:eaf5:e2a7:e486]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::9817:eaf5:e2a7:e486%4]) with mapi id 15.20.7409.042; Sat, 30 Mar 2024
 15:23:58 +0000
From: Erick Archer <erick.archer@outlook.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Erick Archer <erick.archer@outlook.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] dmaengine: pl08x: Use kcalloc() instead of kzalloc()
Date: Sat, 30 Mar 2024 16:23:23 +0100
Message-ID:
 <AS8PR02MB72373D9261B3B166048A8E218B392@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [1H35qK6MGHoef3vB4Ews3U3ZfWukVP9B]
X-ClientProxiedBy: MA2P292CA0003.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:1::20) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240330152324.6997-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|AS2PR02MB9882:EE_
X-MS-Office365-Filtering-Correlation-Id: 9acbc5fe-8466-48f9-1e8e-08dc50cd6b02
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0NDMjEXFprC93iWqdDdQmdOwbhO7dUUWI4Fy53P04p+iI2X9KbNPhax+RSVGi7Xj+oCtqXIVuj5zoE5qIDOSZGD92JElnhAjSKESydZk64BQVmxBFCPC82p6JuZgnLjQGZQghS56AIfmJCuxr0tDn5LEvjZOcApjg1DglqgfgCCfXfqloz6dtM3AFdr0BDbzk4U5OxZ06YE6apVaahIkjquOCan/RJQR6jZacCpjUWbXDqu9l15O5JTjVXHiAhJLM19ng8BfsZpyalgn86NBjrKXaYBHm2dDguireL2zVW0x0NUCaCg8sTa6jrD4Ol8eEN6vK69xJwu4t+LgtZeDd6NjS31Ihy8e3y/btSMeFleGSpqz8w2IfmUbmI0ENot/w5UEv2G0MJe+8K+DjO5sRMyU0JmmJrxGvcOqb75QEfLgm23B8axgJjMGMFdUeCPAeYyuVddpbmduSxtUGmv9+gHQdaU9ecbkv7g4Gxb4IKbbl/Z6PrvsM/vqWJDpln37WzM0cEWYk0tue6dwh8lujzAkMADnqnb8jTNqHb98tBizbuI/2fBnqJM34FdxC82e/fg90ryv0fAl8okphw1Q6Fr0Jk87sNcFg+JVG3WWNhOVRA9SetwRcS2i2XwnK2lxWCRQXY/Qz7MLPcqwe+nnzSsCt4+Dq1CmbQt7yMtdUrP+YUfRGprF7k7Gx0NMTawiva+prWIpnp6QjKByXzaB6g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0HGE0KKMrerG8fW8ZVNVKakfgO/am0xbrrLhef+1jcscfzfb/L4P5xDDpLOI?=
 =?us-ascii?Q?D/Rhie2g0TkNtnC1daXV+LIM60rl0eGgwYzqAdxMsMYMPHAlSy1egDTVnrQe?=
 =?us-ascii?Q?VzED/E0GRovOGUCPNNzFE0LcnNRvRPK2C8PWp1Kawd2S4yyByEUF6ypidUl6?=
 =?us-ascii?Q?/QkeWKqe+TPamM9l3k2OlKb3tUWsVHiN1jfGFmkLKrpupDZH6JT5GQsWxacc?=
 =?us-ascii?Q?KT/oBMjtsVdpSY3Bk54gnBoI/MNzCcUgze1fxqzXvyVX1yfLaNiCOg+0yzWU?=
 =?us-ascii?Q?8fk2JAtwmKq637U16jkpogmYLI40X54FvYnQfO52vcAaRym2+LrAWAhQ1I6A?=
 =?us-ascii?Q?wV6Ku32nwp0Qig8+10ODiX+nyNQDa7TDw/7Kd01Zkg8uQiQvwxD9eI7ULh9H?=
 =?us-ascii?Q?O8OzO5KCrVwv6NbOZuWjV7UG3iWeeVH6ES4DMOvXE07tCFfP6xRN4oHSeYx9?=
 =?us-ascii?Q?j4WDurJLaJmEyORW2fsEeggwwuWPVKl58zsjBaChZjZRtxAhl3PcD7heUocL?=
 =?us-ascii?Q?rsGdaHBCZGDIYp91lPDUFZJ4D8okK0EG6/T10TASdU33//vaxjTupDLUdMVd?=
 =?us-ascii?Q?g7UjRs0RzqCs6rpTFIZFzX0dWZ8CGhbG8Okypo1YCwSBxJ7ZPpxi1b/CBI9I?=
 =?us-ascii?Q?lr2k7rNjs5O5GsQKS01Pun6s5yv+81ElDxZzJdi9xWLBPD2XstYJO0z2oVGe?=
 =?us-ascii?Q?yjH7MQAWBOsS6SlgoLWAa2X13/9ZKT1+Vl4m4i0oAsWurZb4qBwwSECY4oV8?=
 =?us-ascii?Q?EHahFCktkDftrGsLJ75UExvEw/Uln4zn4zYzE95XRMMSt+GZF9AcsQq5IB0u?=
 =?us-ascii?Q?KZNvmp9bVTtcT79fr2CZiEPk9jLPVfL6Fg0V6Ap0NaQGYhRojKUJfDr58Xf+?=
 =?us-ascii?Q?VGLsFa8l3VlloFPtm+XWosL5+CDvM4Vf0YcRKgqyKvPvyikkWTAqR+JEue3p?=
 =?us-ascii?Q?FepXxVFT0v8BvEce4cTBr+/t7OBb86L/5MsyvUqA74ui1Pf7NIyhCBFrb2az?=
 =?us-ascii?Q?+ggnqbtw8gqC2VzYvmropJ22awpdc2NVMI37AheHRaHhJs+I8EEyoc5wXL4q?=
 =?us-ascii?Q?uP9V9NgljEJt8SqOnmVOrWS+YOxzmzY5MSCbJwq6k2ems6iDj5NpN2BA7qan?=
 =?us-ascii?Q?xr9QuMMrowpoFNmfdjQbNosgE3A5sGrlHnoFbIqcnH/A43iSytp31rv5kr8B?=
 =?us-ascii?Q?i0t4P1Eb7LQfdhGfTVLjxSNDLwULUFSeIHXhUA0e60hXgq4VKFLe/+oSQwhE?=
 =?us-ascii?Q?lLBpDEdDlr0ZPRzYHb8t?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9acbc5fe-8466-48f9-1e8e-08dc50cd6b02
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2024 15:23:57.5121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9882

This is an effort to get rid of all multiplications from allocation
functions in order to prevent integer overflows [1].

Here the multiplication is obviously safe because the "channels"
member can only be 8 or 2. This value is set when the "vendor_data"
structs are initialized.

static struct vendor_data vendor_pl080 = {
	[...]
	.channels = 8,
	[...]
};

static struct vendor_data vendor_nomadik = {
	[...]
	.channels = 8,
	[...]
};

static struct vendor_data vendor_pl080s = {
	[...]
	.channels = 8,
	[...]
};

static struct vendor_data vendor_pl081 = {
	[...]
	.channels = 2,
	[...]
};

However, using kcalloc() is more appropriate [1] and improves
readability. This patch has no effect on runtime behavior.

Link: https://github.com/KSPP/linux/issues/162 [1]
Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
Changes in v2:
- Add the "Reviewed-by:" tag.
- Rebase against linux-next.

Previous versions:
v1 -> https://lore.kernel.org/linux-hardening/20240128115236.4791-1-erick.archer@gmx.com/

Hi everyone,

This patch seems to be lost. Gustavo reviewed it on January 30, 2024
but the patch has not been applied since.

Thanks,
Erick
---
 drivers/dma/amba-pl08x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index fbf048f432bf..73a5cfb4da8a 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -2855,8 +2855,8 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 	}
 
 	/* Initialize physical channels */
-	pl08x->phy_chans = kzalloc((vd->channels * sizeof(*pl08x->phy_chans)),
-			GFP_KERNEL);
+	pl08x->phy_chans = kcalloc(vd->channels, sizeof(*pl08x->phy_chans),
+				   GFP_KERNEL);
 	if (!pl08x->phy_chans) {
 		ret = -ENOMEM;
 		goto out_no_phychans;
-- 
2.25.1



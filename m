Return-Path: <dmaengine+bounces-2630-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A107928754
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2024 12:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD8DA1F27854
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2024 10:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB808149003;
	Fri,  5 Jul 2024 10:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cxVmuSMT"
X-Original-To: dmaengine@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2189.outbound.protection.outlook.com [40.92.62.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AAC148823;
	Fri,  5 Jul 2024 10:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.189
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720177077; cv=fail; b=sykg0YK8ZOGfhlg6YP/BbIF/GvwjqZVgd7VnEErlzn0xMh2uOU/1zv7g8OzPC4etmeDusfTciiR95Kt+9naRwXR9E4YYjeKp5VXAfQhBjPgOp2yWkiS0+3hvl2fre72zjNCBHlpKGpwQcfX9wVvxNGYNEfNmz44e8Z4z2W+8E9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720177077; c=relaxed/simple;
	bh=BEtXVKOMTxHhFjtZiDebB633PPUL2/4jNRjUEfOMPLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gogkoLHnk0p1DR97mHlfbEkc5WBkzRxnVR0+AYIuuLot1L0wplU3WP5THU/8GKuPadXI2jrLhSaTZiHhKfoI3fLO3VLl63BNadr4NsUbTUVCyfp4djknRn6aWOwByNNz45A/InX9tcm08AIr2e9gIAM0lMoMJsPbyFTbmYSiDNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cxVmuSMT; arc=fail smtp.client-ip=40.92.62.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xqx23E6j37OkYOcOOnJ+b/LyZL1C1kR/u48WWPKhRoGFBDT1vfVjn1feEDQsP/24cZ0dOsNzKUqFf0+bpkhY9BZb5u9jSKOC3B3Q53TkxJ7+xna0YSVO8IYTyZpuKHD8x4ijTz7qso1I2UNjUxzOvUXNVvVA8oFL5Y+gIFTaaj8Tfl3+Qv3iQp5CmJTiYNhTFIcOTJ47BxwQhyySVDoR0GSS8tfrk33RySWkWVhOTLBmAPPt1GMC220O9cEoH0BWalAiWYHEOCzRKVHOq6oXzdUiQtWmzw+0LFxrzMK7AdZvVtppd6FJSZWMh4NJsQgUAOkTgyN2PAn9UIqejpGcfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUuzyZyPB6KbWl3hZON5Mq6rLG1d3867d6kuRsj7s4I=;
 b=BRvp3LoOWi9UUQLBX49BqZ2XAwb4D+CultpQygVpKR2sHAxDlNt1RYd4nT7PLHbgzDYc4mtySjlyAVNgZdPdaeN8f43SnKQrIwN7qMIW2+oXcf01mRB5b/7aA4DAuxT4ShyjvqVnjOcbeq7k1zbbpC1H/HvXOEXpD//v48EsRebkOb76St+b3YfuKvbxPQ3kKVSJ/7+QcYYKSTiIPqynXqyzwBYofiy58Q5OyFKqAZF/FQGT319kMqwPaLbJ95TPmda96Siy5B6wYuvLh/+Z9LZcs3JOhngsBUAhEuZsTIz9qaLK7qP1RGtZ2IxXdfaI1/t3RXJDycxJ1NBQGafPiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUuzyZyPB6KbWl3hZON5Mq6rLG1d3867d6kuRsj7s4I=;
 b=cxVmuSMTQVGN5C7RJfprGcAW8PU2SCoPB8edS+hdXhpfCJvK0tjHD9qAcBF/6pIDtD9vue0cgYAcSYJvsmd1MX79dgAdnJDaRhBwPXiegkwK4HQ1oWUcCT+xLfpBKxM65PUz0A1BD2D6MEbwGkF9DCzN1Kk3BfXl0dQ4wLsEtZCzytdlviDZWWC3igGYw6LKiv2h9yjdlGVuS3wjzHoVcdvVDyLMeWP3c2ZeWdEK9wh4QJfn1XPAQM4MEvDxnHzlL/ZXYtIwwkoEekyo8F4lcCBv2KKvl1aGcdFT7ZCKmeAB/uBXch0/QUwD/MrBED69mkZrQ0ZZK0MFMN8Mtdo6hg==
Received: from SY4P282MB2624.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:133::8) by
 SYYP282MB0880.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:bc::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.30; Fri, 5 Jul 2024 10:57:51 +0000
Received: from SY4P282MB2624.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ed78:8dd5:170a:bd04]) by SY4P282MB2624.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ed78:8dd5:170a:bd04%3]) with mapi id 15.20.7741.029; Fri, 5 Jul 2024
 10:57:51 +0000
From: "zheng.dongxiong" <zheng.dongxiong@outlook.com>
To: manivannan.sadhasivam@linaro.org,
	fancer.lancer@gmail.com,
	vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"zheng.dongxiong" <zheng.dongxiong@outlook.com>
Subject: [PATCH RESEND 1/2] dmaengine: dw-edma: Move "Set consumer cycle" into first condition in dw_hdma_v0_core_start()
Date: Fri,  5 Jul 2024 18:57:34 +0800
Message-ID:
 <SY4P282MB26240D98F157B616B3AA2E2EF9DF2@SY4P282MB2624.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1720176660.git.zheng.dongxiong@outlook.com>
References: <cover.1720176660.git.zheng.dongxiong@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [PvPdHy+SPVrL92oz5S99Cuc/TyQtK4of]
X-ClientProxiedBy: SG2PR01CA0146.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::26) To SY4P282MB2624.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:133::8)
X-Microsoft-Original-Message-ID:
 <2682697510ff0d4bab484f003d45efe8d03017c6.1720176660.git.zheng.dongxiong@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB2624:EE_|SYYP282MB0880:EE_
X-MS-Office365-Filtering-Correlation-Id: d284aa16-5e98-49f9-ab5e-08dc9ce15094
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|8060799006|3430499032|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	YwxjL8KQQxneQvruTE5ZWdSPKbIY1ObofPgMC3tjgas7FBkkJQqdlyKei3og/JZdi+f7n2NxYQP3e3IcEq3NLZ3ZRfXLw9VYSXn0gIi4yfJ3D64RdMvZAGpxMGmYFQZhw82K85Yazc2Io5LjurbJeV3zMC3IiCXIvdwxjZ/A0etvQJ6OkJo9u+QSZ/smKzPTz9klAoc/3GOOJb5t8JCRmx8Y9QC1ZzzNi1iJgIyR2ZFqUvP5D+tRpwqUiwkCv0ouBkrBHFcV7t9P//HA2zaUiaUuJbtIeUXPEdcy4Jee6LA4+e7Zm473UMeUB8qhFtWe2tE1cPGvd9gcSbQ26wVOeWJ3sle+6IbnFEzurcTLVwn1/9Bj0coCMpQLkOrjGEIemmudvJSwr4/JkR1S+Ef2lLq6t5ZD5tsuaC5x9JEpJxBAV+3Hzl/9e/gXC0wU/llwNql4oi8htp1yvIlUvVs5hNoAZmrkst+pVJpK8nkOQaVa9hyGwGv6AlFdo4xNye/4Nv0HN3gE3Vn2aqvLjxu3vp+5XKYEfZOjALW/hBVgr6GwTnoFANB7XP5+p+Nb2lHpkv0PQGQ1IlnvS33YTsb46BrLcN4YlFXFrLnYpqLfFksTxxgO2Ksp39QXXetIPttVGvufQzO2i7j9Xc2U+ronAdmsOESNz7k1x1sFqepFpNU=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dGa4RIt+k4r840Q1Exl7YXU5AQUM60rXYCg+vGVPAtsRdOZiMJChe6ZGFnoR?=
 =?us-ascii?Q?zpKU16EP/i/vpHSDcUxpl/hcW+Ordt6vwKKRPW5LSaYyElir4Fw/mZX8dOct?=
 =?us-ascii?Q?oI8JUWopE+uf6tAeD44O6XLLoIPWXP94Tsqy4kgvXlc7G9LhS124cSZISiVm?=
 =?us-ascii?Q?TqA8Jre7GwsgMI3/4+vRguFINDD0lvg0sNvC+WFtky1x4rNSGRNK5mojPNnh?=
 =?us-ascii?Q?hfAjrdZOh7qqvrcJJ18HSPSD+D9s2FG0ee8rrITKf/pLkRuQClPELQ32G6Nm?=
 =?us-ascii?Q?NqTxR5ms6SiNRxPkConDxam4HgiGvFQKcAPN2ud7iwgsu/sVji/rrHA0EgqJ?=
 =?us-ascii?Q?ogfBkrMz/FN+NSieIb1zqO6gbguZjQ8795n6iEGeC44jj62bL0+dx2g1cSNH?=
 =?us-ascii?Q?7ykcfgg1ibik+IpEuFBqGzPFI+9Ks9B6ZI8LAJOQ6QyXOmfaCOKBHGoceKDv?=
 =?us-ascii?Q?p177+ENEOnR8vIV7h1oYDP9PiHNqJONyiJAiawacu9agUoOhjECSdQ84jpdj?=
 =?us-ascii?Q?ZxboVYdv9Z1nGzts8sxlkdnpcWxpwWioOpmHln+izWW/TPn5NjFU8lU40YsK?=
 =?us-ascii?Q?DImsm9DNLbm8M7Eh8KUBCuErAZy3uTn8rvA4pVE57UMt2spWcTbkgx05gpf4?=
 =?us-ascii?Q?Eq5wX1h88MoBW/89andJ3IxIG5UlYeWAVa6Q2NO0y6BlawTHuVo69FZrsUbh?=
 =?us-ascii?Q?ZNK+C48prxkcMVSVB5fS5hZCe93/9XMvjnGM5bo9jisLs5jKHyU8KGp/AUeD?=
 =?us-ascii?Q?BVtOw0EBrJTfTk6WsvFo/ef+rQzk9DY9i+G4c8uK0FPjk+SodTIEER9DBHSh?=
 =?us-ascii?Q?T98JdX3f+9Aoo5/fK0ktwKEXVrOD5OChvLPSXQLwBd2SHoPxEERT9BPNztxy?=
 =?us-ascii?Q?3NrHY+z1N5g12F3Ps8dej3dXmC5FHTgFxM3OL3FxCnRbOsI8xFhsodI4WOeq?=
 =?us-ascii?Q?3J2u5LQKSzPLvnbc1/mGAyVl3808egLGR3ISvrnJmmDgDkgvFwOstLWqHH1X?=
 =?us-ascii?Q?8b4AJDlH3uujg+t8HoHYqRPJGKK770mmagYmO4TuWmBwMYxLtFHY7ER1j7+K?=
 =?us-ascii?Q?Rv3oGWgWcxShyf6oUajYq3F24mBfJKhJziZPo17mCKQW3EosIt2GX40RTtYp?=
 =?us-ascii?Q?Q/xkjw4faDu5sxIFE7WL3CFKVEJp7IjqbVm9fyA5vru9o3MnbB92NbmccAUY?=
 =?us-ascii?Q?Louj23h0pxhA7w+bwVY648ZsC3HWeJXEhoo7AadPWfFqkhK21GUbdNwnPWDx?=
 =?us-ascii?Q?eZoN9Mvh2hYr8JIrrc3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d284aa16-5e98-49f9-ab5e-08dc9ce15094
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB2624.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 10:57:51.5678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYYP282MB0880

Two or more chunks are used in a transfer,
Consumer cycle only needs to be set on the first transfer.

Signed-off-by: zheng.dongxiong <zheng.dongxiong@outlook.com>
---
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 10e8f0715..d77051d1e 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -262,10 +262,10 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 			  lower_32_bits(chunk->ll_region.paddr));
 		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
 			  upper_32_bits(chunk->ll_region.paddr));
+		/* Set consumer cycle */
+		SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
+			HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
 	}
-	/* Set consumer cycle */
-	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
-		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
 
 	dw_hdma_v0_sync_ll_data(chunk);
 
-- 
2.34.1



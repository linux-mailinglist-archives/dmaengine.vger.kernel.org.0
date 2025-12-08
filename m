Return-Path: <dmaengine+bounces-7526-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F224CABC69
	for <lists+dmaengine@lfdr.de>; Mon, 08 Dec 2025 02:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A699B3014B55
	for <lists+dmaengine@lfdr.de>; Mon,  8 Dec 2025 01:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52471260580;
	Mon,  8 Dec 2025 01:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="jHaOCiIp"
X-Original-To: dmaengine@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012008.outbound.protection.outlook.com [52.101.43.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5102512DE;
	Mon,  8 Dec 2025 01:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765159089; cv=fail; b=rRlnWX4CkPVKVYEx3tOxSJRPv7hxcKFdyIg4GUfQZ+b4Rf40mlSeQSTQtxp8oKBkM7L1K9Oez9nOxRuFoWVay60blFKjcLCsb6VccG8jPilHFsX6sRH6ce6BMmUIa3yJt6l7mCCv1H5TcqYN4vAj+CN6L9x79FRwwP64FSaW3l8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765159089; c=relaxed/simple;
	bh=vlkOHKTHHq+eQKZx1M3IMN7460KgLmPyGXLScMY0JoQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BuiiATStQgBdHNbeduNTGSSWxyXUnlUEbQfMwSZTknCHBDystn/SqoKhOEiupHOq2CezZjeNQljyNPUB/pQklS+l6rs+bhlSQFPyrwvjVYFVARdeK1sVURHAQvN3d4oFdMWVyd48HnTTbfRIdYU/3fi5+3Ay3l4TIPbw/vhwtsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=jHaOCiIp; arc=fail smtp.client-ip=52.101.43.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G1OvwCrYPLnhhf4lAryC6y/tH3Ax08tH2W57t0dgHPXY6LavCy0pp9LMoO1ovcutO6z62fO6xgPqWlNazcLC9EXMFzSuoVHs8EecLIuf7sVd9HdyL9zPhpU8j3Nu2D35xgl1xyjuXHkjHcvHp7kPuh07OvQLQE4BUrf938Wlk6qfPAFQrTKaVBsf8k4DoHoa6/uOX1LZi/1TF4kO7h2EdrsQgHdPuJihnjrE31Yv3uKBbSCnQ86KzAX2+kBnNcpiAxuGeVCNAkaJ1KV3c3/iVOrCJ3JQgEssMHyJpkGjyOcnoy0HyiAW/iYbcSf3jj4pAhOux3O/i4T+z/7EFVuxiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TRgJ0Vr4q6O+p/bGdJYlehhVaNCSQ6NNuHUwTTLKIk=;
 b=vdCWqQpvS3c4zLxlqLFkyaEsX7SsPTcdJCP6Dm8dUR0+0W3G/ERPbHRa7N/SfGBEgS44pRX9sOi9j7eITVje4gpgw0EsJW1lLgtOp37BPyRwlq8S/LsMzgEVhLB/cciG4JcAunbJJZhwCWHgs2uo1qcyHaDOFp+JFAFFR+ztdKBBySIoL2aoEPPX7DAPuivnLH9NvQDBNEi+vdmdmlIhK7lkhlSoIWaQbgq8LlselnheAc4FvXcmblx3/4AqA9pZAAm32lk7GyneWutt2ff5fQ0xOeS8IPIiABqfs1a4R9WGarwbFR/zAF5iieBV9OdywYNRpAQU3bIEdc/5/boYHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TRgJ0Vr4q6O+p/bGdJYlehhVaNCSQ6NNuHUwTTLKIk=;
 b=jHaOCiIpmi16AZlMra3EB91YfQfD5tTMB21UVFRQlCMDG96AntfmJ5mM5OcN03lQhsvuHD6aQLGsRUZpDBtRw/LAEOb7v0R3MTi0EGpxo5dywNvbSPlkIQmke2XRn3A8r3110fIw73It6Opges31IKDefnUoPPe3IV/z8DECjC+nhg35cKy4osJeuPQ3mAk0tTmtJHIEr0cGk4fp8uQLQuXzjLHRaIu/0o23HFGJvj8W+DcF0X200RJ8Avr+5cWFCl/3dS6yI/nQTuegzwkx9ZSpmB5eityaA5WIkyOOQ0Uo523avNUoLu+EwvbenjE/gyubA5TFdonX/vzQ0U8nsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS4PR03MB8447.namprd03.prod.outlook.com (2603:10b6:8:322::12)
 by SA6PR03MB8010.namprd03.prod.outlook.com (2603:10b6:806:437::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 01:58:05 +0000
Received: from DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a]) by DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a%2]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 01:58:05 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v2 4/4] dma: dw-axi-dmac: Add support for Agilex5 and dynamic bus width
Date: Mon,  8 Dec 2025 09:57:45 +0800
Message-ID: <1c160c5169f6f5b6ff49e7478171bd5c27ff9b4b.1764927089.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1764927089.git.khairul.anuar.romli@altera.com>
References: <cover.1764927089.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0237.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::32) To DS4PR03MB8447.namprd03.prod.outlook.com
 (2603:10b6:8:322::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR03MB8447:EE_|SA6PR03MB8010:EE_
X-MS-Office365-Filtering-Correlation-Id: 078ca213-22a0-47d5-0eab-08de35fd3a21
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MQhYpEd7GGfxK4GbaPtXRHbjlme3z86CB7u9bAoZl+RP9AWgKrEa3KdoupyE?=
 =?us-ascii?Q?mp+ri0xn28RTD6x14lm+whywcRdVMJchVTTwpyHrCaoaXB/3W+x8DOK5CQIW?=
 =?us-ascii?Q?MA5cbXWvRiYuLnsRDf/OBy9LHYVuQlNT8vGRL17LnVZUOH9Dx0qIBhWgdkB1?=
 =?us-ascii?Q?QfIWCC8e73jS/RGaMK0cEEhYW1JlK+Z4AAMe1JD5SnmRS4XC4NxsrCuZDJCn?=
 =?us-ascii?Q?xOiToCBeRPn3toUajMQjORpK5XGWVqQgiYJekbbLRwhcxcOlllG7hw9dDkC6?=
 =?us-ascii?Q?G0ohF5te6+SKNbp+AKqrDvJjzMoIbdLuVKojoPZEd02GTrI9agx20KHtXUMC?=
 =?us-ascii?Q?0vcBDLm0L7JhVJ1FuX04sAqSaFIztZi0n0KhoJE/sB44WTRVSE8js3mcGwRb?=
 =?us-ascii?Q?8KYnM1h2UiD/yIi1gJ47yLVSZnUTsd0NEwjKv7ysStL1FkJifCVRMHrB/Vjx?=
 =?us-ascii?Q?Fo73S4rjxPITsbzRrtyK6zC6dCeyujcZ7R4qRWb291vTq5FZBXtP4EoCHIkh?=
 =?us-ascii?Q?jFqmHv8ef00VEoFEylqMTDipOzU+juSVonbk0nXkGWWuuktCagMI6b0qVbh+?=
 =?us-ascii?Q?Bc93N2S4EhIiocMTDP5ooOqGwYEA85fQ4U8wFfA+ZRy3zhOXq3wRNrhaFZSK?=
 =?us-ascii?Q?3wn0kYK8YWnP7Iel2l7EKg0PmWzZjdPG3qECB7giwH0HBALsWiJc1QaaDM0L?=
 =?us-ascii?Q?usqKdz0YyxnexN0i4hoe7nonOzA0fhVZkRGpNFNkhbcdXWlKqK/nQSGvquQ6?=
 =?us-ascii?Q?aNwrO/YtJeZc970Mp+CxIUOk7nl+hoIXDtJyBfBgTnTfooUA0Xl9i/MGpAS1?=
 =?us-ascii?Q?v/8Gd/BLyOAGTRoxF7ocB4upoJuiPyzDLCUHiPfjwlW6C/Tb6VPl3K8T9aXC?=
 =?us-ascii?Q?SbYeinE3vlBL03StKsC40M785hmmxm6wI2q7+eLXbOgTsBC808VA/xesomcS?=
 =?us-ascii?Q?Im8XWaW1fTPp5p72wuZ0XscwzYoN9lsnTkfLGHK5RI2JFRXCug3kp0OcUWLh?=
 =?us-ascii?Q?9Caz2xLjtj7d22D5iltVKxBTFJXRHC8ycyv1GHWPx5DIT2AYLYt0UELjHzl7?=
 =?us-ascii?Q?id+r9do0eFwertoNU/xkJ+n9DUo7JgK5lu0QO5YdCDb+Bn5qKFvqNkuDxcjC?=
 =?us-ascii?Q?4FVxJE+dR9ef66BDDKtJq8h/q4goeffN53FI/gZI2ru16Wb10ZwYq9OttpC9?=
 =?us-ascii?Q?N9D+MTtBgnGGtgEZLk0srb8iOwdNm2eFHpBq9ZTiCiJl3YvTgtEWwuIzDpsz?=
 =?us-ascii?Q?iZwr+90DQ6k3CKmvqou6aiYTmr08oxPCX7TIvZCLKy3nr7MTmKUUFQtjTuuh?=
 =?us-ascii?Q?0ScQE/UxMkS7DP4ppPJrw2759V/mB4LSzGwq6Y5982annHnG1wgEAJ0lj4x9?=
 =?us-ascii?Q?AGTqEgEh1jswRL7C5C3S/qi/SeIE54hTxmN20Og3UE/uAWL7sqNSvJ1EkiYP?=
 =?us-ascii?Q?M8jIrvcSCH0HJgWVO7u0p57xGeBK2MjJgo7EdkAc4BhdLLaci4044dzeSc5I?=
 =?us-ascii?Q?2vuwFzi/xGTjG94=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR03MB8447.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5qJvJbxq/NoooSJiBRbay4cs4tx70dvFXlTk8hMb5GVV6j2GlYF2fdWwy6Mv?=
 =?us-ascii?Q?3Tm0UE4zT8hF8EMW610WfQTf0kjh4g+LW9LI6RLzQhBc62EPGunGBv6RG7xI?=
 =?us-ascii?Q?bzPKJs6yNsgNPpkubiuB0neBiVlaaCy6qhU5hza4siou9v5QASF2B6ayfPXk?=
 =?us-ascii?Q?pu5OkzT7sqRfqZ70hBOLvFy/B6V2SZlT0uOSz6BwC754BkMJCPTkQ9zzOVRH?=
 =?us-ascii?Q?/OKJ+RvlX6j+BsZtHjW2DX7oKUkAO6A2BTzNX6nlDLioVqein5DzvTrXXL0H?=
 =?us-ascii?Q?CqzPYigp6Vw8FsIl8MpdDD4DuEIx3cbaFffMLggB5067yjYPwbPrfzxyBGwk?=
 =?us-ascii?Q?nfpY3zR2oeYSlsaCIfsDiJzGt8DAfV/a3vwTDdQ7yZQ9ua3kM4ELgMe+MUXq?=
 =?us-ascii?Q?2LFJtLkPTypjo0G0AH6dlaIU17Ifx8yEEJRYjsrfOCN5BrZ2vSms0GddaVwN?=
 =?us-ascii?Q?skjvh4dFXOCGc/gLzHM9/kf0HEAicneFOgXUto2TldLI38Sg0dIanjOOHAFu?=
 =?us-ascii?Q?Yp0M8Mqd+IBURnJuDR1G/xIqAYahCQrSVnHsWrwI4e+relE2VHi9Ey+XkgUf?=
 =?us-ascii?Q?r8NfDhVwEq4FrX5cOnU80z8VsFDZ8bkPQ7CMbwo5mj9M1Ij2PnZHmPMhaV4w?=
 =?us-ascii?Q?GMvQ3UZAEctmQP+IiCKCBsZ/61pEFCjF1Lq2Z2Tdjfqp3kZKuowvIZmI7O9J?=
 =?us-ascii?Q?Qxy5FvMeXze6UMKZrts7ztlDAa0+s2+nSzTEfOFrrNiN9aGMBboubR6s84C6?=
 =?us-ascii?Q?VpaTp2jZaYZPpFQAlHpgGLf/IK430UeArFTuiPIpHwmOtV2HkgJiZPwQpvSf?=
 =?us-ascii?Q?3tiZ8O4zx8JAuzF/OejCy+yCyq5ioNHa6p+2vILUQ+1kfF4Y4GUaEN6o3qaG?=
 =?us-ascii?Q?Py0hRp0NQMyzUuk7bzr0yqmqbsM1/3MmL2B/jYnKhvTicCzw2HVouhTs2x2/?=
 =?us-ascii?Q?+Utr9afMsW4uvDgANjd68ECvAHmwOUG1F1oHQHLS6Z+NA06pqmCT3Etzxk88?=
 =?us-ascii?Q?6SbxfFx0IwI3vJkEGcwh8pfelX8HAbAzWN6qai3s1JDUilajlFQB9wJuJqj/?=
 =?us-ascii?Q?SvV+M7lcl0OzD19c3l66riwO71Py4ShbAKe/6JPJ+EJDOSAyUSVpGyvqe2ts?=
 =?us-ascii?Q?uLEFXGHF6ec9z28tIve4+rSHhshWQ3p80WVAvzovZRmJs3i8ZsWy+Bx6NtS2?=
 =?us-ascii?Q?3JgA41n9bWrVt0shv6RAIvqXyzzD/PcGeyyP70n3Btr5Htf0l27mK7gOtGx0?=
 =?us-ascii?Q?zFyzw90IuEIB7eVHbnAR6Z+JK2j2t5vMiEJ6w9JAFVt5bhQIPHEHH+mc6j4P?=
 =?us-ascii?Q?krXNjPdjarEVuz4NqUpJVLf04E4jNHCqrduuquxLl1ZZFbMYCQWIXCJobZBP?=
 =?us-ascii?Q?Ef4l5YIKw2NB1QJZoNz2banSi4U3rS/GpxQaLTLjKz5VKno1U681oHFh1Lf5?=
 =?us-ascii?Q?LYeZ8AWE6O0p2DKxoJeWyT/anK8sWGSgSIpDyQ84c0jIQaAw4DfIHQuGFH1c?=
 =?us-ascii?Q?B6uVdedlmpTF+Di1Oo9penA7qSZaJksU8qZnVgahMZ9UohsMI2lUAPZxJzSC?=
 =?us-ascii?Q?7Ik7buIw/1PU61jS+bRmT9ikw/zuxCMwKb9g0+r1lEuWjKLMHCrNW3juvXKl?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 078ca213-22a0-47d5-0eab-08de35fd3a21
X-MS-Exchange-CrossTenant-AuthSource: DS4PR03MB8447.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 01:58:05.3825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fYW/k6gZsvonI8pgdJPg4qa+R4/eRSMpXgjTHN9YqVDO6jJowWsfEAaEIBP22szwYWSBd9o2VfHQp5mGcOol0C65xDUQGzF3MAXMPksRSnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB8010

Add device tree compatible string support for the Altera Agilex5 AXI DMA
controller.

Introduces logic to parse the "dma-ranges" property and calculate the
actual number of addressable bits (bus width) for the DMA engine. This
calculated value is then used to set the coherent mask via
'dma_set_mask_and_coherent()', allowing the driver to correctly handle
devices with bus widths less than 64 bits. The addressable bits default to
64 if 'dma-ranges' is not specified or cannot be parsed.

Introduce 'addressable_bits' to 'struct axi_dma_chip' to store this value.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
Changes in v2:
	- Add driver implementation to set the DMA BIT MAST to 40 based on
	  dma-ranges defined in DT.
	- Add glue for driver and DT.
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 63 ++++++++++++++++++-
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index b23536645ff7..165481b4dde1 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -271,7 +271,9 @@ static void axi_dma_hw_init(struct axi_dma_chip *chip)
 		axi_chan_irq_disable(&chip->dw->chan[i], DWAXIDMAC_IRQ_ALL);
 		axi_chan_disable(&chip->dw->chan[i]);
 	}
-	ret = dma_set_mask_and_coherent(chip->dev, DMA_BIT_MASK(64));
+
+	dev_dbg(chip->dev, "Adressable bus width: %u\n", chip->addressable_bits);
+	ret = dma_set_mask_and_coherent(chip->dev, DMA_BIT_MASK(chip->addressable_bits));
 	if (ret)
 		dev_warn(chip->dev, "Unable to set coherent mask\n");
 }
@@ -1461,13 +1463,23 @@ static int axi_req_irqs(struct platform_device *pdev, struct axi_dma_chip *chip)
 	return 0;
 }
 
+/* Forward declaration (no size required) */
+static const struct of_device_id dw_dma_of_id_table[];
+
 static int dw_probe(struct platform_device *pdev)
 {
 	struct axi_dma_chip *chip;
 	struct dw_axi_dma *dw;
 	struct dw_axi_dma_hcfg *hdata;
 	struct reset_control *resets;
+	const struct of_device_id *match;
 	unsigned int flags;
+	unsigned int addressable_bits = 64;
+	unsigned int len_bytes;
+	unsigned int num_cells;
+	const __be32 *prop;
+	u64 bus_width;
+	u32 *cells;
 	u32 i;
 	int ret;
 
@@ -1483,9 +1495,56 @@ static int dw_probe(struct platform_device *pdev)
 	if (!hdata)
 		return -ENOMEM;
 
+	match = of_match_node(dw_dma_of_id_table, pdev->dev.of_node);
+	if (!match) {
+		dev_err(&pdev->dev, "Unsupported AXI DMA device\n");
+		return -ENODEV;
+	}
+
+	prop = of_get_property(pdev->dev.of_node, "dma-ranges", &len_bytes);
+	if (prop) {
+		num_cells = len_bytes / sizeof(__be32);
+		cells = kcalloc(num_cells, sizeof(*cells), GFP_KERNEL);
+		if (!cells)
+			return -ENOMEM;
+
+		ret = of_property_read_u32(pdev->dev.of_node, "#address-cells", &i);
+		if (ret) {
+			dev_err(&pdev->dev, "missing #address-cells property\n");
+			return ret;
+		}
+
+		ret = of_property_read_u32(pdev->dev.of_node, "#size-cells", &i);
+		if (ret) {
+			dev_err(&pdev->dev, "missing #size-cells property\n");
+			return ret;
+		}
+
+		if (!of_property_read_u32_array(pdev->dev.of_node,
+						"dma-ranges", cells, num_cells)) {
+			dev_dbg(&pdev->dev, "dma-ranges numbe of cells: %u\n", num_cells);
+			// Check if size-cells is 2 cells.
+			if (i == 2 && num_cells > 3) {
+				// Combine size cells into 64-bit length
+				dev_dbg(&pdev->dev, "size-cells MSB: %u\n", cells[num_cells - 2]);
+				dev_dbg(&pdev->dev, "size-cells LSB: %u\n", cells[num_cells - 1]);
+				bus_width = ((u64)cells[num_cells - 2] << 32) |
+cells[num_cells - 1];
+			}
+
+			// Count number of bits in bus_width
+			if (bus_width)
+				addressable_bits = fls64(bus_width) - 1;
+
+			dev_dbg(&pdev->dev, "Bus width: %u bits (length: 0x%llx)\n",
+				addressable_bits, bus_width);
+		}
+	}
+
 	chip->dw = dw;
 	chip->dev = &pdev->dev;
 	chip->dw->hdata = hdata;
+	chip->addressable_bits = addressable_bits;
 
 	chip->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(chip->regs))
@@ -1669,6 +1728,8 @@ static const struct of_device_id dw_dma_of_id_table[] = {
 	}, {
 		.compatible = "starfive,jh8100-axi-dma",
 		.data = (void *)AXI_DMA_FLAG_HAS_RESETS,
+	}, {
+		.compatible = "altr,agilex5-axi-dma"
 	},
 	{}
 };
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index b842e6a8d90d..f8152f8b3798 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -71,6 +71,7 @@ struct axi_dma_chip {
 	struct clk		*core_clk;
 	struct clk		*cfgr_clk;
 	struct dw_axi_dma	*dw;
+	u32			addressable_bits;
 };
 
 /* LLI == Linked List Item */
-- 
2.43.7



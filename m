Return-Path: <dmaengine+bounces-2631-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A06C928759
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2024 12:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE6521C236BE
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2024 10:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3341494D1;
	Fri,  5 Jul 2024 10:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Du/Ae7VV"
X-Original-To: dmaengine@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2153.outbound.protection.outlook.com [40.92.62.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CBE1487E7;
	Fri,  5 Jul 2024 10:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.153
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720177079; cv=fail; b=XJN2YApCykOll2442PA8O5UxLZFE1JbdeF/fZc9iYp4GV9T2e6EXCuYURhVAGEOtat4Ud4l1Pzo8Ehh4aQO0fnOSpVVBtDmQf/50icHXxJzs3GnoCkvj4Gz1G6In5iwzq4aPZmDc7enJqev2O6q6PmB5vJBYbLF/M1Pjp5tVTzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720177079; c=relaxed/simple;
	bh=/lYJeNCa440ckCAbiBKuMEotJOEQSOJMZumXJAtsNKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hdOaGYr9lA7hQOzGhQnXqmm6XEOe1Jongln0wlviCVTl/eFaLZ2Y675WTqsee2/s0y8UVokqfC8W4fYynxPjNvV+PtE0T7FSVAdg0Zo7s73ODlF+O908mRIphRBtS3SkZ1NNS1/BPqS7MsgvFAzBHjEZOJktd079uv3YtGHEHiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Du/Ae7VV; arc=fail smtp.client-ip=40.92.62.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdWMgKeUaUxPff52ILGjLCroaKn21mvNEITDaRKTnzQikquQJpVITvwRlwJ0KHkNVBcH+bzyyHpbFr0s3jJ0R73sWyrsffxCypOoIpxPWvliPB15RPNoJ5HToRD4RTt1SE2ALWWyymFgav6q++OzUfU9dk9jL+edseQ0LcA1i6RBxkpGYzOFJcScGesxvw23fw2VfbDHR4XJmZdsjoYamIJcnqnCvoxWSJD+LpmWNDud/CAREJnOF4LdfwMXApOM9MNH1ucTgo2WQ/CIK2BQNloeWpspbSyL+38f6u5H9i5C3q4GTqkMEVSXOldvy37744PBxRBh4CYofogZOfEkSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/I3G0oq+GfXcfUIg6o292lWiODPBPYER2+MOKhmtzU=;
 b=M8lmEq1nggIyYoUcVx206aE4TyxZ0JBExsMLPvE/W4tanUQBBofN34VDRNmzJkgQTFfddCdTjlGLOQms5saQJT3hy7+OLwQMyWXC1y/wUumXH2EpAP//E0FNPPUpddQpWS99jI8q3m5DX6N+vQ/Md6KeF5jq//Re2iChQQy3MLzoysLstf5BxqHuKzDWPLXttngZd9iItxF0eJI8UZfEo2zg2MYWseq82JET4lnAlLUhvw+w/3jDesH+safVAT45N6eduYvXFO8tLex4ci6xhJSXR0tIuISsZXx9JJ8H6sb7OoiZkIQCCSzDfiL7LtlUFHYMM0Apu4Lnd/QM6k0J0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/I3G0oq+GfXcfUIg6o292lWiODPBPYER2+MOKhmtzU=;
 b=Du/Ae7VVkOKlxqIKXChgzK0eo/q6kGXH+MBuf2rCIC/WhywPQv/xDKVusv8dHj4SWzVvfRlKVP+h6gmj58OqBhOTZEM3WlhMWmT8xhtxGRbjoefIlWkf09ru4H3y0LS7tq0uX8DvkvIOOS+JT+ARvqNOHIdOAW0ADHDB8SwWKLcJeK5uQTPnDCVgg5j6ilpOv44wwro45iISBySCk7gWMoiyYJwSuE2lkOkMGa9YwkCA6Gxvq1ek3vHXdTfC/TaEfzY+rJH5UdJeTb+9DxQWc397M0w1h+wqOLuI6y4v6VDwO2cgtxEEj6hO2OHjvXgqkFlgL1LtVyLP2nN4z1d3Pg==
Received: from SY4P282MB2624.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:133::8) by
 SY6P282MB3992.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1db::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.28; Fri, 5 Jul 2024 10:57:53 +0000
Received: from SY4P282MB2624.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ed78:8dd5:170a:bd04]) by SY4P282MB2624.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ed78:8dd5:170a:bd04%3]) with mapi id 15.20.7741.029; Fri, 5 Jul 2024
 10:57:53 +0000
From: "zheng.dongxiong" <zheng.dongxiong@outlook.com>
To: manivannan.sadhasivam@linaro.org,
	fancer.lancer@gmail.com,
	vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"zheng.dongxiong" <zheng.dongxiong@outlook.com>
Subject: [PATCH RESEND 2/2] damengine: dw-edma: Add msi wartermark configuration
Date: Fri,  5 Jul 2024 18:57:35 +0800
Message-ID:
 <SY4P282MB26243F37A69E54C2B469DFB2F9DF2@SY4P282MB2624.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1720176660.git.zheng.dongxiong@outlook.com>
References: <cover.1720176660.git.zheng.dongxiong@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [XLqajbpJrmCwqtYCPhMO5UX6jHzDlMNL]
X-ClientProxiedBy: SG2PR01CA0146.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::26) To SY4P282MB2624.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:133::8)
X-Microsoft-Original-Message-ID:
 <aa3b99cec40077d051c0063591017c4d12455ef0.1720176660.git.zheng.dongxiong@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB2624:EE_|SY6P282MB3992:EE_
X-MS-Office365-Filtering-Correlation-Id: 04bf034d-1bdc-4c13-8105-08dc9ce151a3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|461199028|3412199025|440099028|3430499032|1710799026;
X-Microsoft-Antispam-Message-Info:
	ROa8xMVlh4o8Zf+mPmT+Zly5xvlvtSRzIdJBgjC5LYOc5Ma5XeEZVl55yH79TScXuv/hZ4EBKIavmxY3wOPZYY+gi8oSpn8Jpqkccid1aZZUpieY1IX0Kzj9ZqzGUTVc1H7CWr01iPOU+yuw9lOjGL85bmoXIyp/RoO+Sjo5KcAhqmYmZuVzL3QWHYE7qL0Q/Qegde46dX/hR7S/wkQQPbSufbUQKD/CP5dAku4VdcEeWHb5BwnNsiSAjYxOH/kPp/whNjFOTxRh8zuibi1CIJvc6rzQCzVRkHQGdNieTy3r+kF6+wPZMNI64x7nQfjzqBF7m5mLqPAPF/0/Iitjs7pgMUvpb3EafZnXHU+xkPFbbXDYQyvLi2TFEM1TZh1aSfDn96Vd5gWY1V+oae+nxX+QvXWo02huYqMp77a9HG6+Y79IGf99D66maBhqW2MV1BpMvU+l/KTw/49JrLHvDB6nNQbWXP2tQ7fnmiD+e9oT7s/RkpUhauArlN0Ge0eqz6OVJFMsipm0B6ThXrwUjEvxOsmgtS6+jzotm0BVaY/UF1bSmdK67wcpEOdD/XmA7wsm39PpyE4d4RvUKUM/6pL0yAyOcjU2lGg61BbyeLGh+JR5aslW/CzsSicee17TRSiUDkr5FMa5KTQvtjXQbVxTgsZIGLnGLSM039xasU/JoExv11BiWjwhm7DRp3jp
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BclTnbSlJjRH0QhOvE58GnRodoPPxAe2DXHjcldDKgLVlo7qwehVsCssUXNW?=
 =?us-ascii?Q?sphuLqlUpeKSkAJGonKG9XuGMTfc/5agdMXcIl+InbJf/YZcP2wRX6nhq4tD?=
 =?us-ascii?Q?Kd8Qlg6iz2Cm7jfQKeGaMt7PlcA07lbTbQFg3315TxgK9HEBeZsxcoeSu7w/?=
 =?us-ascii?Q?S905iQ98G9ZllR+Z6XY5rYuSXofWHMCR4wCL41kqGStidP6MGSpETaakxF72?=
 =?us-ascii?Q?mL4BCjG2NDskrEp8SEWxDnYXkaMS18sx8OvvPtCH50Q037A5EHetHRYqrOJ1?=
 =?us-ascii?Q?/EasgZ3Op9b2TacJzgSnoltAXcO8xfdNEhIO6l9UjROKol37ZPU9KSCdat3p?=
 =?us-ascii?Q?Rt7JrL7pVqnotQs7CmNDGRikz55tKJfRjDMIfgrAsbLGNWuoODSAjNkMBHIu?=
 =?us-ascii?Q?xh8QOvnzTjOrJP/i8YNmPMzc/kmfHP8CY4wMtvgdVJOX/pliuCTLdgjcXu43?=
 =?us-ascii?Q?BEtfhL68Z/BpAw04Wxl/t86NlDGi9eZS1Y0iEnSTE4EyAVCOn4rnVjCffShv?=
 =?us-ascii?Q?eI+tTqzldJqCitMnYWdMU7laZ+5KzXTWh7YDSeFGDAn3FHSLOSS5u6FGT3MD?=
 =?us-ascii?Q?9TplHR2vYr21IdtL4Wojf8B/OypXIrZiNIygRmZ5xYRyFRhfVedNomDnjwFi?=
 =?us-ascii?Q?/6bn01pkQXDu7CIyo0nD8tkwPiJruEf6qNTmyvlm5RWLllWR8eVIinXgJGdE?=
 =?us-ascii?Q?dxEDAGNVWGoFWa2jUv08ryc1FOOEprIVlOEGOucl/TyaUY4c3/D6HeaszC/9?=
 =?us-ascii?Q?0hf22IvU4DuJtSBWEefbE4zEirT4XqrR57GlfCMNUxV3VJwppdmOYXVCyLHX?=
 =?us-ascii?Q?zpJ+J9K79SdFz1Rk+FyBT2WPldfDGAS8q/0LH/mTMupTNn2cz3p+AZwKeSee?=
 =?us-ascii?Q?h8vcK1uPrpZvgxzVauWTaGb+qo1UvGtBfTocDdf2Mof4/9KSpNN7DyqUYekm?=
 =?us-ascii?Q?h5ZfaSOwT3OWITTwgA3cXLioygSHkiYuAhx1rvOoGLR5xxaFYIBx8oN60P7R?=
 =?us-ascii?Q?RohtavOE8bRcZKjCvgc1oGd6ldxC3ZZfafkdtObx30P9sAXWCZAMxYnrt6ss?=
 =?us-ascii?Q?xV2+vM+dUlNVVn797aLGV8Fl0BH2dMeAkNPVE3D8LolcgDn9YTTU2LooE1m3?=
 =?us-ascii?Q?iEfqvancr+HjfkNVBtfd3TjQJ3hoYhGdX6Ydcg5Q3KYO52zmjejRH2tRXNI7?=
 =?us-ascii?Q?RdmdQXB/Ev1Dmnb1M5iILdzPMW6bC5C9mGCOlrP1hIeX6dPY6B/CXpVEBfsF?=
 =?us-ascii?Q?iNXwmbNX98z/gipMhOT/?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04bf034d-1bdc-4c13-8105-08dc9ce151a3
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB2624.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 10:57:53.3492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY6P282MB3992

HDMA trigger wartermark interrupt, When use the RIE flag.
PCIe RC will trigger AER, If msi wartermark addr is not configuration.
This patch fix it by add msi wartermark configuration

Signed-off-by: zheng.dongxiong <zheng.dongxiong@outlook.com>
---
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index d77051d1e..c4d15a7a7 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -280,6 +280,9 @@ static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
 	/* MSI done addr - low, high */
 	SET_CH_32(dw, chan->dir, chan->id, msi_stop.lsb, chan->msi.address_lo);
 	SET_CH_32(dw, chan->dir, chan->id, msi_stop.msb, chan->msi.address_hi);
+	/* MSI watermark addr - low, high */
+	SET_CH_32(dw, chan->dir, chan->id, msi_watermark.lsb, chan->msi.address_lo);
+	SET_CH_32(dw, chan->dir, chan->id, msi_watermark.msb, chan->msi.address_hi);
 	/* MSI abort addr - low, high */
 	SET_CH_32(dw, chan->dir, chan->id, msi_abort.lsb, chan->msi.address_lo);
 	SET_CH_32(dw, chan->dir, chan->id, msi_abort.msb, chan->msi.address_hi);
-- 
2.34.1



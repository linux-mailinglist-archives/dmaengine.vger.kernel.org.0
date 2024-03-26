Return-Path: <dmaengine+bounces-1500-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E5688BE83
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 10:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E62491C3C0BF
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 09:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A66537EC;
	Tue, 26 Mar 2024 09:55:17 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2095.outbound.protection.partner.outlook.cn [139.219.17.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DBE4C3DE;
	Tue, 26 Mar 2024 09:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711446917; cv=fail; b=tNgKboDc6ZCesYmIOGy6t/3pe7fmQx3rcmwK5f0HJXPfuu0kZ+hOPT2/dUhvKUfJ5HDTsDkpIPpiN2KXNzyyDnoMHql0vx3KsNgc7k1GRTbpNPS5MBnTiY/UdkYK8V4mn54QqVXpJYM/lDpT/w6RYUKaCjLrxHSf3LAAqiBCdek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711446917; c=relaxed/simple;
	bh=0HjnIHiT+yfS1bbzxfJEpXp9G2qwhb8hF96L+oXZ8bY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pumeq6iLUyl1aFBEhqOulrMvYKIlC10MLD8b3JGyPjVrBWB/ct85iNYEgM7JD1my8wJWg0rD+nv01vMcw6ai1RvgnmtgMZhjosCQagb1nT17X/h5p12n++yCz+Tkye6Bd2vFR1yPUncEyIyVHnMXloVbggKXVy3SwY0RlPSCaTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sd24mgxZ4yqk058KAL8URtuyKLhNHyymGK1HWC621xJpTO4lBQpElfC1Sel662XldWF/1NVvbGp9epo5XIeEMim5Pv5uREZBGGfW6xyy7XdtWOSBB98XaipBDK/xSUA/mTk1vi5sQRJot1E6DssrBap2scGl7dMIJR4tmi1jlNB1poQfZeOLp96X8DCl/5NVtmZ9cFuZIccWxo/C/0D/gxif3n1jjwo06ooUi/NLroHrAkTFybEtiBbza2Jb13Yow+aLVFNQ/tXUVcNIjndUhb5xUVPclS5umuyNK+/oMj+HIHQs5AksbRLCongulzqML3Oh4Gx+MAsply/wv8Lt3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CoL5SsB6Z9q9NId64s+rVU6hL15YzbB+YAz7+4EU3sA=;
 b=MRP3LYm5ZV8VtUl/pjoh+jm6xpCEMHZCM2lqk4sF3MrBaSMq60S9wsdhsuAsCS6Bb9rMlWHntk5CBO0e2e1tFY1Gt/qOTLutkMEbRYmcC5iWn0GrZCOCq9ODfzwx0v5gb5CMJ96aNQwPVY0Ms9dBHMwqwsAoMoOb8FgC+Z3maztfs/YNUSHc8eUK0SyTj68Ldj6nvVbb2xEixvtHAcedb2OGJqiaEHIs0gIXeGbiJO5K3oz27546AKgpECwJpa2P+195HXkLg+1HyTrybQiPXZl5NxFw46qz12jn7K1bQfqTyuXxNoFd4BdLcUDjf347pSZvoOmBhqEoixiaJdWgjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::20) by BJSPR01MB0660.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 09:55:10 +0000
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 ([fe80::d0cf:5e2e:fd40:4aef]) by
 BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn ([fe80::d0cf:5e2e:fd40:4aef%4])
 with mapi id 15.20.7409.031; Tue, 26 Mar 2024 09:55:09 +0000
From: Tan Chun Hau <chunhau.tan@starfivetech.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Jee Heng Sia <jeeheng.sia@starfivetech.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add JH8100 support for snps,dw-axi-dmac
Date: Tue, 26 Mar 2024 02:54:55 -0700
Message-Id: <20240326095457.201572-1-chunhau.tan@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0027.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::36) To BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::20)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0595:EE_|BJSPR01MB0660:EE_
X-MS-Office365-Filtering-Correlation-Id: 12ca5493-0a5b-468f-d53a-08dc4d7ad2b2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PRlEOpLlQmLyDKhxapbnAQUFH0PmtjqPnrZGNVSb1pBeA55fsTtv5KyyofaW3Mo0i4X/RPRim4b/37KaLYJuAer/K6dvqn5QA9VUG4Gs32QfwinQ4ZMQXDHJfRLfQ5uTkdDR5f/6W8rh3LCrpATtQD2TLYB44G0JG1JQBXbgZuL5uj5B6c1SXDSwH9UrI17DJcmjWK+8wSNlFHdaQiX+2vXCT+d7+zufYV4+Mxf561Dvwx/bAURRlTXki0kgCxZn5Hxn7LYsvGY+RPwUmEDrwgd8ghd+77SnRG1pygPjMiD6/INhKduSM8NCPvRargT51luePRxQhbBR920l8weLyvg8obmgwPiy9vw8bt1ibQDiwvsFISA23B2LKcdIPzj0mQyBvBoYnMn9V/q+zQN0Ar460mGInRAKXsMfpZSIN28FJmddFJji/2y62cqCVV0+50+i2IL3jgVC/mQPBiW74jVKlTZi/QPh+rYK1C1dwNUAikfolW0brSDt1EeCprIiz93XxzTwbl5gMwLPyvNJaGJYdXLdVKRZHMVhv0vNpx8y9nNR533yAWbve3e8ii1d46g0oUakdDQoopOC7O3RdaLS4UFuCNoPfx2p+hW/4da5VfiLCeIwnrlMa1K6oW30
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(41320700004)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?18RrbBQs0fS9lJxtvpkJ+/xdz9ff+fIzXs8rE6EsCuuIDFzx3lbfEmLpqE/d?=
 =?us-ascii?Q?bMd3Fe8uzWlmS0ha7SoB9BavjRkUVDCwpciPiFPFutxtwhglE6xH+4zuTphP?=
 =?us-ascii?Q?Ayy2l2NY+Ojk3HdQEecZdlYI/FhCqgyLmqOGhtlran43Dq30ngcee8flECXj?=
 =?us-ascii?Q?tHOKaj6s8sbSD6EMQvjvlDVfUC0RLZ9kz5691vvUPmt6WZkrFT61eaxZJElb?=
 =?us-ascii?Q?gfDannp36czuCLswFi27beqmrMhdXezDKiDmuoVvabAogWskENXAEmKbb5Vd?=
 =?us-ascii?Q?SBtsGowOOrF5xULnbpb3nzk1qSIBrHVKkH0GDpb5eb+s6+2b694GRf75yLs9?=
 =?us-ascii?Q?Nw5nTNn1EKh9lfAAeI5dWjJdSx3gSsJ99F28QYZ+9SdcLZkvNQM6m+Qh3upY?=
 =?us-ascii?Q?ofaj3ZQOFhlJdpqDJmSFXw5e2sa01MYNz9jOeKk7kAGr9WoV1tKj4k6Kc2pq?=
 =?us-ascii?Q?hylGehGDxdYlIM+rgg8/qs42MpJI9An7UYff90aVODtoNfa+rCh2cYt7iorF?=
 =?us-ascii?Q?zTCurAZ8YjsfOMGTj/W1Tse8XS50gVLSf3l4rKaTrmeeLsZS9Uw8wnsJgk63?=
 =?us-ascii?Q?bqoCdEsXwztvOuTnMmHGsqubailkJgYjxJZNgHRoJVVqzb/Au0V91xF5rPnZ?=
 =?us-ascii?Q?wiKAu3IxGmMDa/GqNpxsZ/RbGs+NJujsoVMbkz1qu+i14Sbir6mPMI2JgSIG?=
 =?us-ascii?Q?Kh2eQELulGxYAqZO7nHfTNcXNBdJOVlNCSZZCJX/w/LRfvlFAOjnM0ovKhiS?=
 =?us-ascii?Q?0Vs35f03RhCc7Yn7aVsc6Nrgqmn9NFdmEe7nhAZwNOxccjBo8xS/PrO04PSp?=
 =?us-ascii?Q?xRtHqX/HxwkubaDHQz88OLgfvlnXD8n9jIZin4EcrknBfAQWkSkaZe6eZ+qe?=
 =?us-ascii?Q?MhI+dkoyHBxiMaUr2DLrWAFHV9Qi20sr9SmjtCBXkoXOYtKPX1bl8VzzLtBS?=
 =?us-ascii?Q?1AalPAaoxsMyn5MQf/bMvPApshObEVUo2wWhrE+0/S/9486dBEA1D/oFBclD?=
 =?us-ascii?Q?vPskj+Kv7oDMUq9ht/lBGH899mQjcZtT/3nyxJ9HPk0KaRtCdVCcwASlaXLf?=
 =?us-ascii?Q?ey2JFPti9iRKrfD4+WAFU0vnU4LWr6ba9tsRISqcTmrn1IttGFatcycjXIta?=
 =?us-ascii?Q?4Az7fAOIzuWkvz5C7RP/8o2Tu2WDd6kG7fMmfv/p85O1MAGRMSsseIIBSYxr?=
 =?us-ascii?Q?a8ITFq/qTCjDJZMy/6YplWcA76jn09xqUYmlkjYxs9/Gd43RkOOOji1Hs4KL?=
 =?us-ascii?Q?SzvGErGL5YS8fy4gbP/IECK585NI6chevwSSF4uKUXXSntSaWqqr7bG8KzHP?=
 =?us-ascii?Q?Ngv/h207pXgAJt3woPGyIPYp8ANmI/lVeOnuGSZGz6vrVVYfDUQUsCQNL1LO?=
 =?us-ascii?Q?gTi2cCIvg5B/+Ycvgoe8fTmKRGlHHO3hytGiWJzhIvI/4Eg1acFVJv731G6r?=
 =?us-ascii?Q?mMYEVg7YWe3czGUtDUUWhSHsFmQ5liW/4OGM7hDogv7KMrnJ0O9UVOOsG2AM?=
 =?us-ascii?Q?ecvJBPIYD2qidsaweKMvY1UTQORaPTB4sF/2C86sq17mB/sdeoD/lCpPDrR8?=
 =?us-ascii?Q?dC3d5+c3qL1P8iZCLJf3k2otRwDKVCM0uc/pVcPTVLa9DmR1X3z32LUIzrRn?=
 =?us-ascii?Q?iQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ca5493-0a5b-468f-d53a-08dc4d7ad2b2
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 09:55:09.8354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tU8NtKqywRCta28vts4kDAfmJdeuXTDbVNyGG9hcxcbwZvVCY+iZPbFwRa3kDlKc+YgmQS/35mfi+Vu/zIWDUevgnfrErKFRK5OskgsEjkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0660

Add StarFive JH8100 DMA support.

Tan Chun Hau (2):
  dt-bindings: dma: snps,dw-axi-dmac: Add JH8100 support
  dmaengine: dw-axi-dmac: Add support for StarFive JH8100 DMA

 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 1 +
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c              | 3 +++
 2 files changed, 4 insertions(+)

-- 
2.25.1



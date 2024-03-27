Return-Path: <dmaengine+bounces-1540-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A10788D4FE
	for <lists+dmaengine@lfdr.de>; Wed, 27 Mar 2024 04:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB6D41C2451F
	for <lists+dmaengine@lfdr.de>; Wed, 27 Mar 2024 03:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A095224DC;
	Wed, 27 Mar 2024 03:24:57 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2115.outbound.protection.partner.outlook.cn [139.219.17.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B7D241E2;
	Wed, 27 Mar 2024 03:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711509896; cv=fail; b=hMWyjKbdKsAuywfCBLstDJkD3K7yBXQv0SPP8xj3lyuLMWfBEAQkYDf1h3IDpQS7HbtXRgneXuFYnJpOq9ktURadvvbz6VrZLsfYOrTB/adkVztpS5Zta+001h8zUQtcWOxtglyDAqeS4be7EHBOzTq1VJCztB9Nw/KjZQzHCmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711509896; c=relaxed/simple;
	bh=I+8KeubN9Ket6sEo1S0uUYDBnW0IHpmRxMlp+2RTlEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=acWXdV5/zOH+WFgand9D9ENo2n4XHC4pHZyu1ODaYufFlji46ahCSGdF5g1MWj2p8BSObZmqUpGTay7+pwlmdBAZGb7Z5OO02XVwHRH/QJHnXE7z5QFbXbEt+rsDkTcEQg43EkzsVWiwDt49feRsg226JX89MCBSZw7kTIQwsYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+64lUsoVWMg8AOjXbpjhABS2hGLFoyrS4qDFwPbFD33PNkJDOCYfrifKE6vfHL9BWkKD6067bIE65WYzB9Jb3cMLvBEaRoedL7HPujh78OCA5IUP1kUF79GuiF8c44iWAelQ43aKvR786rt6DZOgvkjJACJcQFJQqA+rAULo8u0i5uIFbGaJMdaajFSHiXuivvnNokJpJGo1kGFv/ByNM5vfMTEDnWLQglrnh3G43OLZ0lAXnryVAL/f84BJdC+QDZndII53Qxm3kPqhbghSjUcfUapdxFECFW8f0a4OwmRB1p6yJvoqwdtkVPCKnkUX3M3/N/KXNP7kpPunAO3Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UaUOPYBU5ZYHN58caPxS/0E/j98Pr5vKldA9lgm0jfw=;
 b=YNH/J6QEiLE/2M/mnp3qLQ3uyRasUVr641Vm70Ei2zLDFiB7WIvwuR+3AJqrVDa9Vgxo7UkJs51cAAYM7O7itozqToT8juV0kpUUEBLi1p/XxbG3gQI4aOQY/l+OYev29aPAuyEWTGzTHJ5DqzQkB2alMudp0QFN8ShE2wJMIf8j7hBUtElUheBrPDAOJYLfyHe+dzjrsWCwCAoT9tv9PRa91iXzZBrzUgpeQx9jPTDLa3yw3FtFhWJLObjfubfatXBBli1F+IajHofFAVgRRGMANxsHxifQXp49/pc77aNoJ+umxy/rM4qP5Kb5rKDWlhXbR3+Plba6/LhQkUhmZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::20) by BJSPR01MB0547.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 02:51:42 +0000
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 ([fe80::d0cf:5e2e:fd40:4aef]) by
 BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn ([fe80::d0cf:5e2e:fd40:4aef%4])
 with mapi id 15.20.7409.031; Wed, 27 Mar 2024 02:51:42 +0000
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
Subject: [PATCH v2 1/2] dt-bindings: dma: snps,dw-axi-dmac: Add JH8100 support
Date: Tue, 26 Mar 2024 19:51:25 -0700
Message-Id: <20240327025126.229475-2-chunhau.tan@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240327025126.229475-1-chunhau.tan@starfivetech.com>
References: <20240327025126.229475-1-chunhau.tan@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0025.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::7) To BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::20)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0595:EE_|BJSPR01MB0547:EE_
X-MS-Office365-Filtering-Correlation-Id: c9424af1-d7ad-43be-f729-08dc4e08d507
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aaKkQB940R8UdO087LSIH8Tm0FFTYXuB5FSYPaiQWU6m+WMB7Eb0UwYeR9VmCrQ55sECmsZq6A9QXm8uY7QNtpjYK4RgEiXRLgS8YvyKYSWDnrLVKMZ12Qo2gI2DUSjep8fVFoNVfZEKtpL5qY7OAX7Reg8iGUAKkUY/Zh2IBwCa9THpVMjIhJwXJfMiYRhm/wVkyUSwunY2SP+V/2NDq6280iddmyo/jm76vNxmnz+bMSiwRnD9zHu7vh3iVFfrK9Mo1SLYfd8cR6c1TNos3taAfOJuV1sJBUQB6KmMjFAJawDqhTCve41kkmXlVAiH4VqFtKmD4SZFcuwgEcz2r180WHvVPsmzg1ag4zMMST8FznkGnki3NW1zPVrtSidADIikqc5ER0WOYv/0RcFfjLM6gAH7fxmh+Uxr6VHzrvdQXfNaFtKKpfTqhKLnMn015vGoGxVP1Y/WyNPxLja0cM8QQaJ3dTHetP6gl74CSjU8KMgQK9JOdBEByqWHvv8ao5CKWkhj9BH/no6cFHZtIp7p3SEvVvxUgLS67kpY8EABxzJmA2r00zcPvUHq3gLFpE2ScB2I24s+MgwXd92bqEy2pfQVRKrzMoY/ZYQyhRK/m8Ndoy3+CeMIx5/vVwss
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(41320700004)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xU5r1OAkp0TVMvHnurugQuETLzacukcapqDigQk55habc4h3C2kE4jQYFOpQ?=
 =?us-ascii?Q?UiPBQZlYqJbFdtJ2wq+OT0g/dFpwZkPkwHW7kd9/IXYTdISPsXIqtG3PxUoH?=
 =?us-ascii?Q?4gaSjNbYoYHsED3//417Rhv1vZ9S6r30uMUZ3jLzyoBKLPlJxNZSEIt1W3kN?=
 =?us-ascii?Q?O9MzvMwrWdnYPsiTcrl4OobRAF4NeJLipRwqPdHK4Uscz1GE06QrIW1OwVWV?=
 =?us-ascii?Q?OUetuwiKMGOzYRnAypzSNFcJbYy+jeAM6GZba4Ok0ANpPg+0I6qbxzRV5ZGR?=
 =?us-ascii?Q?zIPGWfg4G74FO47Zi+yE1EXvIMqyPdTG8673GL0L4wnCc+kWYDnS4E5OWKXC?=
 =?us-ascii?Q?lB2p1Fhonsa9zYRYTnkbQS6HuPUI/HSIMlcVCleMswNLKRaytP7xcbVkcqRf?=
 =?us-ascii?Q?T1dLp9g/m7ZIf8ad55HW+WTZTG72wQCAx5J5HnsMD2SelRPZPdkx1HkN+g+I?=
 =?us-ascii?Q?nJsBuY9vr/9LyVTvoLbCInedVbSaX5ioL6g2RHpaerW2gTeev9geQWwF0Lia?=
 =?us-ascii?Q?ZJ0rNtAOcBxowP+NEEZBbYA9DZNJLht0mJ+Pp9cVCSQjcBv2X3hWpuQv0P/n?=
 =?us-ascii?Q?pm+/VbjXLv+rVtzvK0KK2hIJACkNAbS3iZiQr+tbaEnryjx9ZuNfF4d1AiFz?=
 =?us-ascii?Q?bq6AF7/LhZpcK8l9DFmPDyK3YN0kxjuzZHvNjkqODIQqXAuXTDVasJsB3GQJ?=
 =?us-ascii?Q?dGDuh/ckr4kjFm5IJd5j6BlYZt6wjs9VTs73WlEttF3LOxYF1Z2ISEeGYuaX?=
 =?us-ascii?Q?uV69nUsOhLxApaIPCbOn1Mk/JXj2jqGCvemTzUfGSDSlkDl/ZsPwNI9upVB0?=
 =?us-ascii?Q?BzYOPqmm8NtLHUoGc1vQJh+nBIx3eAzaMjqcwDwCcyKPaz02p1735R38SPy2?=
 =?us-ascii?Q?rbaBR6LRlZ6AvDNMX3RDQPbczganZQ2XREDIUjtxjym6WEl96RZR1fSbRVAn?=
 =?us-ascii?Q?UEoElL9e0sQEHXsLQ4g30YRp5YEVgj6scNazp2rPuO/V/8VNnIAZ9K1SmglQ?=
 =?us-ascii?Q?PSkVhl061u9qExiq2XHoCTnAhFCJNS6ebcYntOr3Fd263UFuSjFl0PqYKvMf?=
 =?us-ascii?Q?EBYm7pmOFmFLAEWqJDMeZargfEfSEgi/eVg8QnSf8X1wv87gXdsAQeaOy/CI?=
 =?us-ascii?Q?YE9rdLNu+YQC2MtBWMfcZN5fkfaVGc0yg62MbTGmKKF2e6rx2gJwofKItqVw?=
 =?us-ascii?Q?6KSEum7XD/bnymfjzIA0olSxQtBqRAyE9zJ2L5YgMha6NtDtj4vhXr2TQxgM?=
 =?us-ascii?Q?fIq/qsyznjWXwn8JDat6E/5adWfCo05Ys0q9lEBab5NXQ4OdBUMKjS5xQwPD?=
 =?us-ascii?Q?Ib9ZeSVfhNwaJp98DiLX3RPUtZyNSbhXb2EYavwWj7aNYgT/07QhAA5NcfFJ?=
 =?us-ascii?Q?CylBr7gN9p1yWbxc58ZMsXZhDdewEQFnWCAQnvvaRdE2wbPvDSo7DIw36Zud?=
 =?us-ascii?Q?yOAP4kD++8/UDTmrIeDX8+l7NvBbdwCMZqnPzv+3/0+xpi3GPFKqmW5LfDKl?=
 =?us-ascii?Q?xD18wbjM4XWwXs13O53K7OHNHIVlyOjVqBm3RxcCTgkunNA4re/4SgndUcxz?=
 =?us-ascii?Q?iMHI+S5WtDml5TfMeo0Bd+iBAgG7uLivED2CmSjLs9gTyNOpyknZdTjV0FVl?=
 =?us-ascii?Q?Bg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9424af1-d7ad-43be-f729-08dc4e08d507
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 02:51:42.2515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5f7A0JH1BQt35NaK7LdTJfB5t178lik6xFPrK9NX07l9GOZUlkMSZjLEggTAZ8D9ZmGSee09gXCZxgRt2iyg81K/YhsnCtqurI/dw7xc8sE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0547

Add support for StarFive JH8100 SoC in Sysnopsys Designware AXI DMA
controller.

Both JH8100 and JH7110 require reset operation in device probe.
However, JH8100 doesn't need to apply different configuration on
CH_CFG registers.

Signed-off-by: Tan Chun Hau <chunhau.tan@starfivetech.com>
---
 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
index 363cf8bd150d..525f5f3932f5 100644
--- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
@@ -21,6 +21,7 @@ properties:
       - snps,axi-dma-1.01a
       - intel,kmb-axi-dma
       - starfive,jh7110-axi-dma
+      - starfive,jh8100-axi-dma
 
   reg:
     minItems: 1
-- 
2.25.1



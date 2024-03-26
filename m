Return-Path: <dmaengine+bounces-1501-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B312E88BE85
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 10:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681C01F62CDD
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 09:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149296027D;
	Tue, 26 Mar 2024 09:55:20 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2095.outbound.protection.partner.outlook.cn [139.219.17.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FF354904;
	Tue, 26 Mar 2024 09:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711446920; cv=fail; b=IsY2BJ09DjJKUEgXef09pFjiTiwnx98Sgv40qTjR+Ajq32OLxVpFfZMrtZUO9iPO7jy9N+lYhCwQ79erIINs61HKmELDWe4THnJmbeF1rg6mfA9/1vWGcnXvJuYiNL9nukOnRsLrcNn+LdfdxZ5GzzQnklFTGj3O8louF6wqYbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711446920; c=relaxed/simple;
	bh=FMV6DpFmt23ZJoHa3dHZxg6oN1zbju+4Za0erPuj+W4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nRjCofmk/aOxNwvF4dJuBsnIOw/IEBhgti9/ibfQ7DS6MURCA7QWuDhc8fajjcrO7vRX/NVGXMfhNGVane+IstdmoYkBAOEmBh72806d1YkP8rxJJiN53yvdeJhQvS2QNM5hJtsue78HVZusqxx0aJDc/DowbEL8PHQiHvh3nH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iphKJ74GRmFUj9qxgXM2TchG1yteMQYMr4u5gBBtBZRDTrUbYRcVUmWU75T/f2+UoAw+ncQu37LgebGJ3mCIMERR1DOqThPksaXF1bfAYT7+1xus7XjPMKDwBL3Nny2HZIJ3KFcJ5tyEzW+cwLyZKFGjZdgLoMahSXFzmUlrMs9T+kymNkK6ahR4GfZMQBVmLXtSuMHqp1N8sD2ZAiUexNyZwOxxCeNWiS2RMu+yY+SiwipdInzuYn+9Vkaw9xJKX08vKwIGGuMxb8r2b7FPOQvZQziyBLa/gxGmNpW0cd+Epwlz0NUritYEyN2BsMgs0gRsA+FbQlLvK2IBFbqIOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXOuEAaSoT6LnF/5Qo5kM0NRharF/JH0Mis5imW9UMM=;
 b=G8WumRxcQjFfSHj6Rl9dhtuQps78iqJGVB2Qvg+nu7G8R8TLa9lVohraUZB1rFcsLzZTKw6suV4vOgs0+M8hcdD1RgHGVcYWOt6loRkJ2Hn2SdlYgB4gZRY+I8LdcHywQVeer3lfLcJlKQPzbu0vezw5Dfo5VOoUXOI2ZlVYNX8sgUPJ6E4s6Xbi2X56sCCZzt7I2vCZhNCtmOKsTWU0WAZXue9E3xFIEeOE9E35SIaddUag31YTirvrnETgxuxyXKVn9kfFUHRxKidXkTK8P161VrYHlth5l5biEFjf81snBsXg31rvC7aZKR0Z0e0Hmo+DElpU5xgWJa2+IISK3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::20) by BJSPR01MB0660.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 09:55:11 +0000
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 ([fe80::d0cf:5e2e:fd40:4aef]) by
 BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn ([fe80::d0cf:5e2e:fd40:4aef%4])
 with mapi id 15.20.7409.031; Tue, 26 Mar 2024 09:55:11 +0000
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
Subject: [PATCH 1/2] dt-bindings: dma: snps,dw-axi-dmac: Add JH8100 support
Date: Tue, 26 Mar 2024 02:54:56 -0700
Message-Id: <20240326095457.201572-2-chunhau.tan@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240326095457.201572-1-chunhau.tan@starfivetech.com>
References: <20240326095457.201572-1-chunhau.tan@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: e899d379-104e-4aae-b6d3-08dc4d7ad3ca
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jOSCld0HEbMmUZCNZhVsl4e8QhQarN7DE3av1HY/eA1dgvtDAGVE7MdydJZ96iGu9UKGZfiqv+C5PfqWV9J0sDBrJmyDm4Y+msdGXO7N74SWv3S5hO8Fyethmld6S0SspNBZ36Mvrb8FQk8GHYzJ06c0xvfwu48Wu/72FGKb9Yz6WIbtBM9Ca+BufuBb0PM/uSzgwZQSxoQXFDJHGGQRc0LPIqJq1qwSVwILxAhWI8agxQU/6JhWj/YSbCPmiIkYsH9AkrQLaXew1AUEj0FKmLJ7dv8pXtzMxIJo3LXCeZM2tvMgI4NaksOgTZ9kgNLo1LjuWVK3YXNj6x0QRjhaljKGpcX/LZ4gA8W24iouV/tjpsXoM+k5h7Xf/DhDI59FUkjjeAhzXpj29JCI7bAmwPc8MTRQk7gySvZgRXRvGfh/Zf3VTcJSPlfPYevj78uomgYb3QswA1oDb4c2H3Tm1JFXOlFH56PhSMWxLyzGRVf3r7FnlLx5Ufi0Xn6m73CQPu4TwtwEUR3fB7fgf6dYjmNTcoubEaTKQDUXgtHl5dPiQbhj7GExAA5VrfWFJSQ4lcms4lh/LNmfS71Di59ImeIRpp4j/JFmo4XU54ejC45dqpYKR2pEaWpwh1Pugm/N
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(41320700004)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6rhJjCXTJPJLaAMPzM3xkFhIjiSWAbBJ+hQO2Fexwv1d16RqevdGc7uo1JhK?=
 =?us-ascii?Q?r4Jzh0NoQJLGeZBvf+Q3g4xQJ2156pPD/a8muvZUAQq1wwjuUT5s3cKHc5+2?=
 =?us-ascii?Q?oRHX8gqI5ht0vNypiXED/LUYJXaqhum3Jps4q5MAloJ9SXPifUi9SFcE2bOF?=
 =?us-ascii?Q?pgrlqe2RD8yewZZekr7qu1md+qdi+shPXcOfuDEFmV8pbVonVHvFxN1pnfrV?=
 =?us-ascii?Q?yIrZsr5/mroRn2QBghMh17h0v4tmCy7JZ/rUKJRWgIh29qSKNL5qtpQzvpDG?=
 =?us-ascii?Q?vQumKpm5IQru3p/FBdYH6wUQLzTsA9/yQb7ErmtjsTMzMZUC4x8Sz30VEljx?=
 =?us-ascii?Q?fDfRcqiLtnlTWRmk78UBG7zahsl0HlwfIvINHnKqew5QJtbeFDXMVEkQdTKD?=
 =?us-ascii?Q?P7AFCQDn6umNfo3yJ2O1I9/DNvtP3AGYOQ4IdSILVk6lMrg+iWukVLDaQTqk?=
 =?us-ascii?Q?ew8nijy2URlrsD6srKaM73EEWauS3Rbyjpz+ISbKlfr4KDvh8wOXlQgQtwO1?=
 =?us-ascii?Q?68fCEdg3pLwtT6qsLhA/eCrgzK1FqWzvq5+FPB5rIRgypYVqaWxbcfVtGuCJ?=
 =?us-ascii?Q?Cwi71JyDKkeAdqV8wMNX8l0jleB/rRVTysnBVgOnlZz9gScTy68L4RdRx7uv?=
 =?us-ascii?Q?KQAXDwcEpZxKTDo7MyIoCJ3RqHVctdFR8j+vUSWMytbTFdnL2Jag6ncPf4yu?=
 =?us-ascii?Q?Fe1DVXlVS2mO3Ft1guAf02HFUMpAGXuoFmVu4WOkn2Qf90AWnRV7c+QvzgLb?=
 =?us-ascii?Q?/LsFDuDcikmI1yAtUIRYsKdy3KAqXVT2gbOwrnEwTzZZPtRqyzi0jTPm94E4?=
 =?us-ascii?Q?Nw1NqaQm20qFKs0uuvtfeVsHWvsTtd96/G/kld67KD+3iRiP/sT3fv0JMhfw?=
 =?us-ascii?Q?4DAYYz4r3Go6qKlnVM3Y+B6KvsBIGTFYfvrHwj5Nks50TdjQBT5nwXYFh8g0?=
 =?us-ascii?Q?70R4eOOCudz1WaDrTK1SopjW4uYEpbZdu3LUexb48Jn0FykLgzfbp3tSsNx5?=
 =?us-ascii?Q?C6qTIyQqjcsd8NpsbpOtU7lFPRYiOjKo21Q8pdWy7GrOprUfOm8irO8PxyXb?=
 =?us-ascii?Q?B/bRNanMM8rdMU/GRUDNLTK8+6yKGtdrb1Ce3Buf8nfIndmc0v8a9sIAyTqx?=
 =?us-ascii?Q?I+SZYMjYGWGZc5HXANtkNdsJ2V4VedZ6/6yT14Hqb2aG9dnl69OZW07YUTu/?=
 =?us-ascii?Q?1eLT9fwSKjygAu9Ll0exbXLFV0XyyRnxfOqehLtNAHxQAdjLsiULukT3Uzkq?=
 =?us-ascii?Q?TgRAiGsxVInEmEtTFm5t+MJrQr+/HSNBw1sJ07I7G8TAGgyhovHRdC+1fpmx?=
 =?us-ascii?Q?k6jToiFsMrTORtiPlfpXpTqlNQ7BsjBb5kq/vzuKNM/+6ZQEn6XMsM4flKjU?=
 =?us-ascii?Q?CJznNY3ktY8pDQCcLHwP8LNn63NtYyn3wCYsg3O43pi0q5pPQvu5DuHhLpMl?=
 =?us-ascii?Q?m9fzpoRvrPXhqn/5R4yOhS0hqlOM0rz5KtlDDwZhxdP3Y4MX3SAlvSqbmbDF?=
 =?us-ascii?Q?mZav1OaWbWMWiWlEOw10wJjuilM4OuW1+rMg0tz3/0oLEvVHR9asAnVh0WGo?=
 =?us-ascii?Q?3L2lSwxFYPHp/W8gJV8NpZyVR6wxbds3bAtFyE2nPneOsWnTjCmWeWiXJOy0?=
 =?us-ascii?Q?nw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e899d379-104e-4aae-b6d3-08dc4d7ad3ca
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 09:55:11.6239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Ps8x6U2zRlhVKKXQfAQMCLV+/liMIOl9/L5UNnyqGk0SCo62ffuyGZ0uzpldYrY1Xtaj9R4qccll5CVgoEx6o9UdCyALFO1nlvt4q+aPWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0660

Add support for StarFive JH8100 SoC in Sysnopsys Designware AXI DMA
controller.

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



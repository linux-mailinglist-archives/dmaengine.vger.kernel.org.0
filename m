Return-Path: <dmaengine+bounces-1262-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBE1871655
	for <lists+dmaengine@lfdr.de>; Tue,  5 Mar 2024 08:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5B352836C4
	for <lists+dmaengine@lfdr.de>; Tue,  5 Mar 2024 07:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110A27EF09;
	Tue,  5 Mar 2024 07:10:42 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2126.outbound.protection.partner.outlook.cn [139.219.17.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DECE7EEF0;
	Tue,  5 Mar 2024 07:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709622642; cv=fail; b=QaAfQmaGWUyBipnO/LKNwIfq5SpPgeRE6OsogsVt25pD4kKSSPaafrEwJM4bNsgWbn1LUipo4GEgoJ9+EJl1VKsyILK0miVTjUFHPF3QuFmGfAX9bFjmVqK9O9Qv0RMQh5FNivnSP5jEcOcXVA9BWK3egQcZsj0pkGpTvgc/G0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709622642; c=relaxed/simple;
	bh=lNROP9rze/p9O5b448AxlJDc8BpzFiD3kZxIoCqqWVc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NgtXWnSm7zCg/EWH9+mv6Gm1nmJBKoDgisryqnDuTfh3E8WJyNxFt7GJZRWJJjZHFCSDpFPW9eENyN7mPwU5V/cHoAXrHXqzDpPD7eps2FB77Iz+5+mQ4ieWmkt2ISKzZ5NaKBO7SzTcKqQETquhOHuRv6YQR2MjdPndQ7UEgHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRgP3CCyh/e+0WwM/t9MjkPpTn7wkjvW/ASl9FgOKvNmgMvr3UdPPpqoIxMsaoHCXUcwZgeojLalbQUK8BHDqbHPBTRCNOUOqxrIWnd+ozaTa9TxPeSENeNEg9vFGFawQnjuFUuvUQlpcXwsAP30g7wxdHPxQelpAx4+o1dda6Yi7q9cYG5fCDBHebIBlHCqp0AID95soeZEwyoXtkW3p89yzFbEey/yEhhEQpKKhX6rCfWUCl+TxTpj/LaVj7tdR1YN3R7P8FvhQtJuYrLYkLuEUPHe/JRM124B0lgAady3E8G2aZf+bwCag6R3rbxbydXW87JWVtXRLF4AJDzLkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fuR0Uo97FEHrTzNlg3XOqVZFO8NJo+NZ32+HTkK0DM=;
 b=MJKO5NC14yr+W1wleZ29jgn8lkUj8RcELd3dLLOGgk0acTo9wffX6o7LfH4colY9i/ujuqOMG9CX3Vj/K+WPJjHid5QCDEqS0c52RM8E2BCdjG0D0qPHKFSoTkPhFKhWDzkEz2vCoHQZ5PhOrP1bqvMzrtEXto8G15IpN8GPgV1nBw1CVCU1u6Ia5QdlBzPcDT9JQfCQxnbidZorAj6nnxk8m7pwlM+B0zWwdyoedJcbo57ZVa9tA75Vs6WRCn0ko+OgZS9LYMV0lW7aLqmRIgAczeFg6qgtsBo2R+Gp1is/IQa8jba2EfMyBKhiFkOxIfBUKY4BVSZWmnoD1+J0bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::16) by SHXPR01MB0462.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.51; Tue, 5 Mar
 2024 07:10:26 +0000
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 ([fe80::9ffd:1956:b45a:4a5d]) by
 SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn ([fe80::9ffd:1956:b45a:4a5d%6])
 with mapi id 15.20.7249.041; Tue, 5 Mar 2024 07:10:26 +0000
From: Jia Jie Ho <jiajie.ho@starfivetech.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v4 3/7] crypto: starfive: Skip unneeded key free
Date: Tue,  5 Mar 2024 15:10:02 +0800
Message-Id: <20240305071006.2181158-4-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305071006.2181158-1-jiajie.ho@starfivetech.com>
References: <20240305071006.2181158-1-jiajie.ho@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0019.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::22) To SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0670:EE_|SHXPR01MB0462:EE_
X-MS-Office365-Filtering-Correlation-Id: 95dec5cd-4a0d-4e40-de3b-08dc3ce35550
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Yd3qHD3a5gxN1G+F+AmvWQF7bl16F6/62NbDDGA0ZqN5CyKaFiPcJ+iFLymMI8x9gCg56RmaipmMkTpVoDCtybfCqijxyOz0oHypY5R30UEap+1iG0disB0VFjrNi4+J8dYMK0lzij8GsTgbd5PSsuBY4zpkRGO8Lalgf548ywUZ2bydo7ddHA35Dp+TIhyEtTUW+XGgsuVWy4Dj6OXHyV+QfhhDTlvFdKpgerzR9ftuFibxNM0kmI9r1by736dIgwxdZGJUH0C9rNDSlWw8IFpYsjFOmr5N6p19H7ZXSIzXZW5HiDs44ZJyMZE75jeFSmBl0MPyLlZKxsBpDWYFoLIQDZ4MIywiTbW4abGIV12/YhpE8I9X5mPcikJ7cRLuLEzNgqYGC0875TSVW0I1aJaNIqpkvBwKj1iDMeujQPpak2VpUXMftRUTacYZUoNjXbzXI0NiKYxzqkFpVbbhInDkMs8v5LUciKVIU4ZgHIQdiDt1SGee231RTYQ1jLGd6VqBD2ckX7qEQCs4bvcDyENaw1TD3JM1PPoV2vKBi/xnWQvhxpeJnbbholpCNjh5V4uyDhln5CdUjn/RpcQHxDEdpxLA/jpVJUidOIr14mxgD/LpqRx7ZDH3KdlOuQqxMH5sJxdI3T5UHG0uD6TPWQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WSK97gnCq20HiXuRxQ+s9a47iNe8TnnLf0YRIINTy05ov7Fceh/YAjM3uw/7?=
 =?us-ascii?Q?mf5zALICS+NSYbUbzVk5F68Lq6QabIRvtOvIjJNVB/1JWP5HgOjX8xo0xZzt?=
 =?us-ascii?Q?9q9X219RPiy2krkVs3+HBbuJQ390mYkOCW2zDBDcPcwvyXKLHwJfCOnPrvdu?=
 =?us-ascii?Q?nySUh6xA3//lAbuSn+jsoTrKSIN6K91s2V+HlJkcCvwSMoqP2PNhF0mOvKIK?=
 =?us-ascii?Q?chAu5w6v4tXkemX+GQ4JvXjUKlnQdy2i711X5pxxfyiFCOjvUpRNa+ceEcjd?=
 =?us-ascii?Q?nX3XDzLJGaEjejvRILhS38HKF81yGWzzETwaFNuVh4N0N4K30/dZx+08Rx0u?=
 =?us-ascii?Q?sGQZpPgJ2bEiuQ6RMDqw+k+V2NBacwGLr3GV7CAukQY+n2Y+P6I5mrce54jz?=
 =?us-ascii?Q?RGglwREkVHP6uqX7QiCxi4Tj5prsl0mD4uId8RcCO07HXO03qPVzozaOn8gI?=
 =?us-ascii?Q?Zs+zPWh7HDcLXcVMq/dUlwlIkyb5wt+jg7nLh4wWUbPHP2tQohIMO03t6Zpp?=
 =?us-ascii?Q?QOqVGdkR5A1yF9csHpzP7a4vYlMubKcgJrUlgLHlTuBvIqwFohJ6dXUuV/1V?=
 =?us-ascii?Q?wNLT6CZxY4nPi9C0CNbRnOmBAZbKneA40Hz3z8FncJOJxfcS6DfqWqaEhz9x?=
 =?us-ascii?Q?QyfNImLqNQDpfk6N/UqV4ahdGTmSq6QHNXMlt95PmG59LG9GRh212rxyI0X8?=
 =?us-ascii?Q?3dIPlrMzMF4U2dZHV6pLhztWqwOPr2qdaLc8XOkuBzrTdDAqt84nTLdBLKFL?=
 =?us-ascii?Q?EKOK/FOi8g/HFeXA1oHyxKz84UGll1HnOlLXvmCZEh1WtVpzfLTBgrBfnChz?=
 =?us-ascii?Q?uc88Bj/X/tAJwueGEaIp6wFxNmDfIBWlydjNQQI/SaQrRP8j9C9lMG8mLQ1t?=
 =?us-ascii?Q?GfxiSE/IncTTrjHVSlVpZKHvwvNgQ9CBh4Jcl8JfdI/mgVy4QglnzRPjLTwB?=
 =?us-ascii?Q?mZQ4zweg1qajKzrGROEgKIAYYiVksI6QnMFbBn2r8h9wYl6a6SmwCo9HOYmn?=
 =?us-ascii?Q?4tfU3HwlCNq9DQUyL+oHZg5uwRR7SBIy+0x/WRHvMzWVZXmhFZxCRCskIURW?=
 =?us-ascii?Q?tRM/kFNsNA1w25qKsOz2Jh3GqSLlKGTGTnQr3rBM6HRaSQVOd6x5Et9LxZ/E?=
 =?us-ascii?Q?ApLpsc3+hFd2VLzUTfzXI2t0EQcgnP7XZ9xm74l8MBuuEM8zDiU2xpkbZAeW?=
 =?us-ascii?Q?ZM3rWf1a9+dexKE4i/W8lhlsMUrE5odKli5Hv5fLjTXQ/FosV5bpixhuqD3a?=
 =?us-ascii?Q?zevMU4UPUMnnUWwa2dSakyH1zOLesaG7Om++ArmPKsY06ynIIyhlHOnbzSWn?=
 =?us-ascii?Q?3g1+faGNlMzn5tCn+LMfOXwTsuoS7xtV2pJo1sPXgz5NT6TM1iVDIWSbtsum?=
 =?us-ascii?Q?3wlGAfNqurNLdReHKnho8OD51Bh9h/XZRBWZFNGpzFl/h1JdQv6HhSgDB5dg?=
 =?us-ascii?Q?GcZVwcO68sPqLJD7XAp5QnifEGAhvP+3be82jaZWbjQnSKFVdYuuXeFZaymf?=
 =?us-ascii?Q?NswPrvBmKrXPV0z9qRz/TUQU7WlFwvzVS1VMlGfF76W3Th47rXWh9ddGzJDw?=
 =?us-ascii?Q?zlqf4eiYMJiDNrnTIWtzNvf3rb6a1I0LWDwCQkB5YO/+uH4de7LNegeAlH3d?=
 =?us-ascii?Q?sQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95dec5cd-4a0d-4e40-de3b-08dc3ce35550
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 07:10:26.8524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNrm+uZ5GMUhYUFVgRa6Lo6siRBaLT0mj4AlKf+gZ57ihYSazKTtB0iG9x7FD7zZMNuiETPfnqImE5ywpAbcm0QnnzMxiBd4ZlaQ1FJUmok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0462

Skip unneeded kfree_sensitive if RSA module is using falback algo.

Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
---
 drivers/crypto/starfive/jh7110-rsa.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/crypto/starfive/jh7110-rsa.c b/drivers/crypto/starfive/jh7110-rsa.c
index cf8bda7f0855..e642e948d747 100644
--- a/drivers/crypto/starfive/jh7110-rsa.c
+++ b/drivers/crypto/starfive/jh7110-rsa.c
@@ -45,6 +45,9 @@ static inline int starfive_pka_wait_done(struct starfive_cryp_ctx *ctx)
 
 static void starfive_rsa_free_key(struct starfive_rsa_key *key)
 {
+	if (!key->key_sz)
+		return;
+
 	kfree_sensitive(key->d);
 	kfree_sensitive(key->e);
 	kfree_sensitive(key->n);
-- 
2.34.1



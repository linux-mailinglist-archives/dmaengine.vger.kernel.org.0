Return-Path: <dmaengine+bounces-1456-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6C88817FF
	for <lists+dmaengine@lfdr.de>; Wed, 20 Mar 2024 20:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59AB41F23B28
	for <lists+dmaengine@lfdr.de>; Wed, 20 Mar 2024 19:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D407085931;
	Wed, 20 Mar 2024 19:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IfeowxZq"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2085.outbound.protection.outlook.com [40.107.105.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3548565C;
	Wed, 20 Mar 2024 19:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710963600; cv=fail; b=RsLxNu9JMp6vbXqXFnyIMgWWQjFlwl2W8FaNA5BU/FQc83ymUNRExb0LDOotrsdZJmVLuCUDKjdw21w4cn89R9G3847FGhQk1krjpVX5j26jqx4pMoQTu9R9AJ03zz8OkJ/QFP54JcXVwv7G9BO5nXO41VeL+91PLn2A0HMV8Jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710963600; c=relaxed/simple;
	bh=j+XZLGzpWCPwQ+2PF27NsqcbXkP+MECQkhlT1c7V/PA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=fX1TSdgMyfT4SHOdHzcsvCsxFf/fFPduOnkqqq4ni6FVlNrgU7D7OwW9tbZ9PN61ZsHvzJYYQHT7T0+HGTGGoowaZIIB08itStJ1SmwAQaGEaO7l0KNTjrtijD/tyZCu0Fq1UyeJuRvqjaYeNymSjO2/XjF/EVvk76lT3oOjMJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IfeowxZq; arc=fail smtp.client-ip=40.107.105.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKz0/ZRgE7cQCS+OGinjTw5ZqagBD7CyqeI+917WNc5r4i1bb7mmz6phHfHvjNTmpT3dZhReZqGMTLvOD2c6oaVosN/PPRreKr7cWxmQY6GB65T98RfnnBZkEfPkf4lRt0LS8+SuRjn6bCm1E5o9utyrkByvlhA3tYkf0aqiYYdXLv1Rgg3bszErEL+gvz4D03ZsrtkftsqC21oFqyvbx89nUeDl2ZUcN1dCF4TIcFpxyYrDnmUC4PdY+QPqQB7mSCCmQfVrwumzOncjS65JpxJyHZR5I0yT5McZChWOKZq+pvgBq+1hUluDKDJOsmvMT9JZYtnotfkAKMX/4UTJ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0swDmfnhC14r+xIYakfxrFAJw3ql26gCjoT2nJQlQBo=;
 b=K4v/fwMjI+sdC6AKUKBuagXBa9N8FbW6yIwpy4pCjzrHNFdK8Q38e8yXilBlp5UVsJhv3xt4aDgNOvWy381uz+KKdqmUkxMzB7Qb+V7PKmgh3a2jTkkuUr9qP93/JNZi6jOx74W7hnU4Q9/s46Fp8b3xFQ5fps3xw1U6lZzetUXynPRpVACcl1iaZ0xHAhiZh4X1qBpBP2rd/wizrt3yL4wAUHlKtHmZMtMFvO0V3xk7Y9Wh6uJbwBUGG+XRIrFkxEZumiJOMlHvvLtQ3L9U2FPVHRCbdkdJ8trvf4pOglanpsy8DuszdJ0CFv6rzx98g5sMIroXdK4Y9yQyxAMXVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0swDmfnhC14r+xIYakfxrFAJw3ql26gCjoT2nJQlQBo=;
 b=IfeowxZqUpM73OATV5Tcad6zyZYhsZAqhqKgOrKrm9WLCtqQjJr2EDMCUw3sPUshA/9AqEQw8PFNO1VpX1cxHzHdonOSO1AIeiQQvi0SC5qUSWvMGXicxdlLmLZfTHkutI9pJYr0gcnQO4mdptt7PgahJUliTDRgqeGIQhrar3s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9326.eurprd04.prod.outlook.com (2603:10a6:102:2b8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Wed, 20 Mar
 2024 19:39:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 19:39:53 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 20 Mar 2024 15:39:19 -0400
Subject: [PATCH 1/4] dmaengine: fsl-dpaa2-qdma: clean up unused macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240320-dpaa2-v1-1-eb56e47c94ec@nxp.com>
References: <20240320-dpaa2-v1-0-eb56e47c94ec@nxp.com>
In-Reply-To: <20240320-dpaa2-v1-0-eb56e47c94ec@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710963589; l=1318;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=j+XZLGzpWCPwQ+2PF27NsqcbXkP+MECQkhlT1c7V/PA=;
 b=45i8mqKGYYo04ts4VX6RvoL4VCyg3bba028IGHPXM3JS9K65ayu9blHp0j7utbPI4sdVP3nq+
 ajaHV2kTTVbCWY6STNoDeech8E3WaKUvCzyB7xAB5aYCDmXLk0P9rl+
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9326:EE_
X-MS-Office365-Filtering-Correlation-Id: d78045ca-9ccb-4141-25ad-08dc4915837e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oFvmWAhXbUMAVebrDRF/BWo8ozE/c4vAtA1QsD9AogmUTgPKvoCcOoRlK9W/ApgeFDthakyxdVLA8s7t9L+zk5B/MFspdGFDy1kIA32OQgnIWD98omWt2OINfkL/srbY3q+c1fhPTV6gZpvpmKjZqeEFP3UELhQcUrRSqnio7r2sQRo/P6NV5O5KPBgQeyzUxE7cupCvOQMzjBP7zlx+lekPc+jagqp6g0dkWNaw3gTPOvGcMpb05ZwXj9DoDywSlLYgtkXTmR5NZzIMfcP1ETzU7sXVMoOUtL42dUqGgz+7EPRtr9cs4q+SAQZVPue/EWGo6rQuT7XbaatiofR3UfXBZWdBcDgPOjmEsQXD3/9h4mGYTXmvD9eTnAMuCRQEW6w0bo0FOJMQYM0gRJLfpambfQ7iMNCN6f7wOSPFNTQiLX37bw73JMECzioY35baZnHKSyNfP42I7bO/7YTF3gvieL1QWiFUSld3hmS08+90lP+TGCmD3+a26JLTw7tfCB1YwlruYxnRD/S3HvVQy4drG794MZtmlZpov7uerQXMg4o2lIgam82GnInHHGs09fUt2EwfBMjMra+tuE8hz9Ik/upo3ke8Y/YYbghj+z8JXDaSn0mASBu9qJGHaT8THmQTufHoUwuXj9kH6eGeAQjTixFx3foWXEDtmWg4rAaNiIBasEShvUAN7r97hDvME5wtMfo/GNUsKNtmjERF4g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnFqcS95WGl2cUlYZ1JqbUM2NEpCbFhxNnVBYnJYTlJ0S0dHM040cTQzdTkv?=
 =?utf-8?B?MTdiaEZWdkdiV2doeElqa1Z2SDNBcDE2dmk4NVJJWkNEeVRzOWdpWGRGQlJZ?=
 =?utf-8?B?RnFVVy9vQWVLSzdsZWlWUmIxZTYxWURuSTRvVWJ0ZjlVZG5jWEpEWDZ2MElx?=
 =?utf-8?B?azlkTjlCbUJ5ZUhDUlVWSURCTUgwY3BPQmtDMmEwWjhvNVJKclFDb3FpMU0v?=
 =?utf-8?B?ZVBZbnZ2YVJkTy9qN2RKWVpURkF5NHR2ektmZjRjVWt2cncyRzAyaWFJWUpX?=
 =?utf-8?B?REFtajlqKzBMaDRpd2g3MzRONEZaVzR0TFQxVGo2Y3pYTURreCs0MGRRMjhp?=
 =?utf-8?B?UU41bnNqcHhCTHp5Uk9vWDdDcEhFU25XeFEwclpQSU5yckdMM1k2ajgxbzBo?=
 =?utf-8?B?bHdVWXBvT3JOQndRaTkwQTgzWlFvUW5paytmblYxQlluVE9FK0o1T1d3U1VZ?=
 =?utf-8?B?TGlMVi9OL1Zxbkd5dm5CTEFFeFFGaTJReENXNjZJT2xWUjYybXdnZWZxYXJK?=
 =?utf-8?B?TmlvejJ0UkNsU2pTWUVGeXdUQlAreG1TaXFZQisvd3JFdXpscTI4S1paNE5Q?=
 =?utf-8?B?eUhwMG1aejhlaVpiczhGbHpNWUl3M28zUG1Fdys1dVNpcDR3cU5tWDZoUENE?=
 =?utf-8?B?bmRSMHBOZU9TQmpHR1k0YjZmWGdVVVI1SEpmNm9raFBQdTN1Y2dGK3F0Y1hk?=
 =?utf-8?B?emUzRkQ5V2lEUllsVUxkMnNSTFBpY3VQbURuQTdnU2d1Z3dGaFNzZ3hmWEVZ?=
 =?utf-8?B?eVVhZzRyZmJhcFRJMFdCNDM1SWN5VmVjWXV1TUM1YWRKaDZwdHF1WjRTdW1Z?=
 =?utf-8?B?d2FSWkNJa1ZUdlJVcW9Jb0JUWTdjVUJxVDVaYVJFKzB5c2E4TmNZUW5jUWRL?=
 =?utf-8?B?WmhTaWM0T2hseGM2eDRRaUlteFdaTE5sU3lxZWhiSFlzSVJWYm1PdEhWSFdJ?=
 =?utf-8?B?V2F3VTBTQ0RISDZJUzBoTUpxNmJoZ2VKL0YwMTUvQ2kyUEVtNllyR09IYlR5?=
 =?utf-8?B?Vkx4K2ZOalpuUk5LMmYxay9DNDBUZlVuR1JSMTIxMloySS9LcTNnZ1d5Ulc1?=
 =?utf-8?B?M0lSRjUwZjRraXBvdDMvUUNpWFA0cVVvcWdoV3lnRFliK2JBNitXTXd5V3Mx?=
 =?utf-8?B?bjkrdWdpeGRndXRRSnZOcnVhQjczaFVMa083WlZiUkttTllqZXZKaUtBa2Vq?=
 =?utf-8?B?UFVpZkxxS1o1bk44MTZ1NHpTMUJBOWJvN09vd0dEekw2K05WL1g2MzBnK2Nq?=
 =?utf-8?B?aHA5RDNHdFE1akl1UlhRL3k5U0lNTUU2OE9Td0JlZWVucTQ3SFFXdkhSa3Zk?=
 =?utf-8?B?dVF0WlVxMldmZHIyRmJxRGZJbUVsaDR6K3lrUkJKVXdad1ByZFFlci9qY0V0?=
 =?utf-8?B?NlkyOW9yZmphdFdzYTRub1NuS3ZFQ0NtTEhrYTZTOU93aTBqVmJROWl1SUU1?=
 =?utf-8?B?T0ppTnd0cG1Vc25DYTFMblhOTkVnd0R1QTlUSjlpNVpQV3NpVjdxSStUSmVD?=
 =?utf-8?B?UDZibHpRUVEwakthOEcvSGNQakdpTUFkUkJiVWkvV3U1T1k4MTh2ei9lSzMz?=
 =?utf-8?B?QzBDbS9NZC9tTVowYitjNE5KczU5bk9ZQlI5ck1tTnQrUjh5T1Y3eVB1VVpy?=
 =?utf-8?B?Tmx4R09MSTZZUk50NkdhMmFDMnR0UkN2QTFxVjk3dEIyNHJibUJwMVVMVWVy?=
 =?utf-8?B?Sko2STRHVmxIMDVBUG92VHJJZysxdldHc3NIN0pGNEtRWTdlWFUwb09Pb3FD?=
 =?utf-8?B?N2V4bThhVFpqYlBuMDVMcTU0d2VveDFBelRCNzdpSm5HbE55M3pQeXprN3A5?=
 =?utf-8?B?REUwTzYwQkVLenlhL1F3L3g4T0x4a0VjRzlKZGhjQUhqUG1QYlVVMUdJZTE3?=
 =?utf-8?B?aFBMTU9LYnByL2t0Zys2Wkd0OHNxRkgzbUZSNVU3MEEvbjl6YkEvNG9SWTdD?=
 =?utf-8?B?QUlaUUhVL2I2dkFMUzdNT3JTaHFkM3FDYzJaRUpTRmhXRS9zTWZjRkhFd1R2?=
 =?utf-8?B?S0JXd2pBd1duU0JWWDBoMjlGdHNQcHFJblNiUGhQbmY5R2RRQW1Id1NQelpC?=
 =?utf-8?B?RjNNODdha3NZT08wTjZEV3NqWlNZNUw3ZEJPRUw0SEprQnJqbnpvWGw1eEF1?=
 =?utf-8?Q?NF3/K0RBAWYmxiKO0VqrO8vzy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d78045ca-9ccb-4141-25ad-08dc4915837e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 19:39:52.9805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/VXnQsniZrd07jcvD4RYUVmwa3AaxpmYJ7PlCS0G0Y8AD+2DL5xXkYvt+w53CJQ44TT/qJLpfI81rdOSK0ICQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9326

Remove unused macro definition.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-dpaa2-qdma/dpdmai.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/dma/fsl-dpaa2-qdma/dpdmai.h b/drivers/dma/fsl-dpaa2-qdma/dpdmai.h
index b13b9bf0c003e..2749608575f0d 100644
--- a/drivers/dma/fsl-dpaa2-qdma/dpdmai.h
+++ b/drivers/dma/fsl-dpaa2-qdma/dpdmai.h
@@ -26,15 +26,6 @@
 #define DPDMAI_CMDID_RESET              DPDMAI_CMDID_FORMAT(0x005)
 #define DPDMAI_CMDID_IS_ENABLED         DPDMAI_CMDID_FORMAT(0x006)
 
-#define DPDMAI_CMDID_SET_IRQ            DPDMAI_CMDID_FORMAT(0x010)
-#define DPDMAI_CMDID_GET_IRQ            DPDMAI_CMDID_FORMAT(0x011)
-#define DPDMAI_CMDID_SET_IRQ_ENABLE     DPDMAI_CMDID_FORMAT(0x012)
-#define DPDMAI_CMDID_GET_IRQ_ENABLE     DPDMAI_CMDID_FORMAT(0x013)
-#define DPDMAI_CMDID_SET_IRQ_MASK       DPDMAI_CMDID_FORMAT(0x014)
-#define DPDMAI_CMDID_GET_IRQ_MASK       DPDMAI_CMDID_FORMAT(0x015)
-#define DPDMAI_CMDID_GET_IRQ_STATUS     DPDMAI_CMDID_FORMAT(0x016)
-#define DPDMAI_CMDID_CLEAR_IRQ_STATUS	DPDMAI_CMDID_FORMAT(0x017)
-
 #define DPDMAI_CMDID_SET_RX_QUEUE	DPDMAI_CMDID_FORMAT(0x1A0)
 #define DPDMAI_CMDID_GET_RX_QUEUE       DPDMAI_CMDID_FORMAT(0x1A1)
 #define DPDMAI_CMDID_GET_TX_QUEUE       DPDMAI_CMDID_FORMAT(0x1A2)

-- 
2.34.1



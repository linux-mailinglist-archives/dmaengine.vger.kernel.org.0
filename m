Return-Path: <dmaengine+bounces-10834-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHoAA+f1E2puHwcAu9opvQ
	(envelope-from <dmaengine+bounces-10834-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 09:10:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 667F15C6F2D
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 09:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3204A3005D07
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 07:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930A33BFE38;
	Mon, 25 May 2026 07:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="XMYOiBof"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010042.outbound.protection.outlook.com [52.101.56.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4773BE161;
	Mon, 25 May 2026 07:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779693028; cv=fail; b=hOYWtLvuHuFZeHeFqd8QhFwQwJUX1YNVlZRt38EjVb+DMCRxuHzN+Q6b6BKi50av9Ztbf4D9MwIl8BqJbiXzLBKu4lIhBQbyb54xDnqU+0Jmcg9mXQhVtgBYC6zMA8moQbxEypYr2+3FUpXQRvSMGwm1586GQNdARVhE7WeW7kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779693028; c=relaxed/simple;
	bh=9H7a1uvvTIsj+fqSs+fdMoCTpulgCzjb0dafsidd57U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GN6YlgYlDz9urT4p9hxMH4h/2pqMNaL1AKvSX2dfarm4JLWj+XUhW9Spz4pzQNNXxedpssYS/V/3CehULa6pst4Qm3NFlhljvzHyCDecdxVTJDFxPVMtLMFvDmoVp0CO4Tg9U/4eJMUVGyK9laFq3HstuM8onz3tGSsLZYYMLIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=XMYOiBof; arc=fail smtp.client-ip=52.101.56.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTXqqC4ib6MJIURvF33k2AVt9CT4gETnOHqvw3LZ+9syEVX/ZtIjLgxiXbQjpC4OUt+8X864FESsgOQIJVFu0MLvVtK1W9JXlMaO9iyFh8vacZAq9tn9mBk90zSF/NWHVNLIniJ0jhBw5t8m8125+d7wBUygKtNYJ5VlKnGWVfcL1DbrnIqh8IE8I1GxkDK9zQJwrIolFoIb0qegI2je7fO6MDYt1GmQgozL8+NV33PBXxxEu4LTBmFk8tEcaLpOUV47i+opWDXhUVdyY7a6L4j3eQK/9jZ/e06IDbZFMvMXX1bGNd9cwe3VwE6TzgkHLcY+4s2fDTDRtcxQVbZs6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzMViZDQHBbvndZb9SHszpRQ6Iht3PMCzt/zibk/Qmw=;
 b=laW9ZbUlBYrUekTS5gmB1InuKxuLVxsLD696iJ2oT2XIPUSjeHAz8tcI//5tEi1qQ5u6cXJreTEJh3x+9fhVqFKU3TWt9pMT+1ELYDlACeVS0rgnFR5FegM3xXEUK4LUKVdNTxxUmVrzLWrxwI/KsHvTBvv9h+d/fxKJcsO9TtZGUe9TMZzApLKiY+33oA8M/JT1ZUf3UAuKLty4cmoUDd3Mh2Hn/jTmkrwo35Jj6XnRFGV4erJvW2tMHDcUogEWcjkTr0FaT7GfWIbUs6ioDlOswhxuGSPyhrT+Iz5Wqqh+mKvFqeKNrrnXMr9eYkY0ai7yitw8jusXlGhDTCi5Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzMViZDQHBbvndZb9SHszpRQ6Iht3PMCzt/zibk/Qmw=;
 b=XMYOiBofLgUieaDLqEymig21aljCdtZgSDdqoW3ibP4CanfDrmYxNBsFjLk9dRB+sQ3jWWjA3IbnblZUBnZzG87MBwB4w5E6/bd/Jamle43QxUHgwPqCz4xMTlkIkRN3fvEvRQinnCbXpv5fKRSa42mGvgoxayrNhaLPMWeLdyIK8EcqJGVqFtSduF9SX6IZQM8xaQyWGMWaAs6Q+NQPsjvXya50Nvc9U92fY+xANI0Gkg4CuHOieBZoNh5ZUeY+9Fn9KGLEQQ0KtU1BtWddKgJeB4UYauFxnTnu1W1d9p+mxB2im2/8vau+bDXr3x9Wj8WzEnmkMPs3jlsJ047Ijw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by IA3PR03MB8456.namprd03.prod.outlook.com (2603:10b6:208:53c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 07:10:24 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%4]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 07:10:24 +0000
From: tze.yee.ng@altera.com
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tze Yee Ng <tze.yee.ng@altera.com>,
	Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>,
	Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
Subject: [PATCH v2 1/2] dmaengine: dw-axi-dmac: drop redundant DMAC enable in block start
Date: Mon, 25 May 2026 00:10:21 -0700
Message-ID: <060733464e19298f670cd269d4849f2092644923.1779688569.git.tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1779688569.git.tze.yee.ng@altera.com>
References: <cover.1779688569.git.tze.yee.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0107.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::22) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|IA3PR03MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: 109c1cf2-d2cd-4b7d-9932-08deba2cb0fb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|55112099003|22082099003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	3uNyWKqe/ZduZXfNGu17TUYCAUd6EAnvqnAPB1W4Gjue8eDd1kdhqWlc2auY395zxg6ie+ikzq4LN7m+FWpblbVRqgLow2xLpwuJB7tg9EqE/xe27LJPsIh6XgiI5n49rB1/p65ABn1vjZVdZQz/hiagfa5Nfl2dRwionQidK1WxOsuMF44rKoWv6hwInLWHzDdzaXfr68IiWcAWkeAv+FixOJRbg2ZL4IoOQG69JoO8Xk9sJ6z+MxCX88fmz4g5ILw36UkPwhglBP7Q84Efh9lHZgrOLRKECatGXbpyMM0ZB84sbiusYOB52waONUKfcmZLa+pWsX3dyUXLSb0zPNr/fqPEYYWftaIafol6t7H6UbuRJOCF5LwIRRFdzG6h/dBtCxoueWxyttfV0hAbbja2GHu7ImpsQA8HA6TKxmN1WBU05Kv7Fslh9N9HwAyqcKWgU+348hdcDFWvTACOI3SaZJECQknQ7RUOMp6Prl68jc1H+gCeEQyjuUEP+i5f5qKrS/cQ43u0u60yBC4xBRTmCX7O2lHVlzkvsjtGvW99lLH1JfIwzuUysxgtDRQ7ZS0zNtvD+CzVBhWWPW1EZ4qnVYp6l1Lb8yHDtxQClReQ3zWRCwFW6l26Dg2AxOfHOauq6Y3Noiut6iJWG10xy0UN5oVXsmEGP5Ibx9g+ouRPppMfu/Zaz/HmxE1g/V4k
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(55112099003)(22082099003)(18002099003)(56012099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WwqEbfi/06m/ug4bZ7Yfa/2abNDuK57/x438iqTC2pAoK7niaoZBFrzvxWso?=
 =?us-ascii?Q?eHbk2yK3wIAh7KMGM3eioCB2XJ05L/bLlYG2M40bdTDSb7Rk5uA54iS8xdHH?=
 =?us-ascii?Q?Trz8JEuIUP0Tc2iJQRzd2IJ8ImjTTgX6dX3fdyoHS2sOA0N/F7kwiTwHDR3E?=
 =?us-ascii?Q?NnXJoox/E0bFy/j5ceGs4LT2tCQhtEdjQtrweRlN4zWw4DDHlozIUVcVQXTw?=
 =?us-ascii?Q?C/zk8KQoJG1hbBsIwnaEyf2lDCiuI2aKtuhpy30WM2vBX1MbxIE3QZyfBJgN?=
 =?us-ascii?Q?V5vleCuB+tiQErBPuTruIOAE8nQI8OCd39RyIRfYz0KXuwzTJsQz3CW8qDVj?=
 =?us-ascii?Q?X82+5g1SJ3LkE6Glr88BtDBPn73y/2sORztR5BiXN5A7EDAZVp1sikiCdufC?=
 =?us-ascii?Q?jxA0fTG5QQmg6J2v0LnkOYKpPSVXr0n8O7pBuaT6y+/HjT/Jq8Vr/V5ezzcA?=
 =?us-ascii?Q?Jn+Ryi+9irvTdwQ+HMhdlngjzCqAwK/krWFgrcxnWcwyHSgETwOQS5oCLlbF?=
 =?us-ascii?Q?Jog+FYMW5RVRpOEWDGHfqcU5oCph5TRzYz+5L7ZMGxkQkhfMy51NdIh/6MbL?=
 =?us-ascii?Q?D0Xu80jNJsVw/DyoeY0jIquJD8Zz4vHE8AJguYbX3SK8fLU9bCAQfqDVr58x?=
 =?us-ascii?Q?0X9B7rOhAHfqygkT7iALRU/uqlhdl0+DWa2aIOqHo04TAGTNvGGbib5fe/4L?=
 =?us-ascii?Q?fTVju6sQqUj2OviZLXcSdFr5CLkYJE9R0sVNIokTBdRngU8/RZ3Jk8MnFz/D?=
 =?us-ascii?Q?5Bnbu0Pv7fcQYD8iRhLasCTqxrQPupbCR5/svN6s3WpI1m7Kxmug7M+f1nd3?=
 =?us-ascii?Q?JJVKyuFbUT8lqHd+H9XhnIlhiCIE3NMOAlG4Ec8FGESMTKXru+xCcekcVNoR?=
 =?us-ascii?Q?Q0ZvZ4qk21CsrbyizAZAOJoyOX48cWg20KGououLg8I2TRmaKRCBOhxxABS3?=
 =?us-ascii?Q?WltKscnP6cURFDZmaiBTI6UyQZx/krJleW3uVumrQGiuOSGfhtm68y1mLy0v?=
 =?us-ascii?Q?cW+TGEznnICtyJvdH/ZePntszPuvZmPvRUEuId++fhMcpHadrmLbuW9HGivR?=
 =?us-ascii?Q?Mm0nmrOv8Ng93BWwxXpldgOybw6rYsOKuQCtszQByuPxdEymirU+8N8NOLnX?=
 =?us-ascii?Q?l5Gjr7jVOEdAI3o8hUJCehWHFNsAzI2kAXQ89O1R4PVfzmR74R8/jAE2V1SN?=
 =?us-ascii?Q?Av9f6YG8zv3aPXGQVHNcE5zdL8MtHXAD5hXqtKaiS5I51DzYGHPa+nZdp7Vz?=
 =?us-ascii?Q?t0rhxKQ75Xoc7yGJHytpOR/hv5VpE3sZY1uSl5W0ADli7/rRGWQ77LlX4Wej?=
 =?us-ascii?Q?r+WDsbFC5lcfKoJLfVF0ZjPfFit23zWWuYUsVSs1j+30f6PDuC/lsGWYwUck?=
 =?us-ascii?Q?vILjGIsY5cmVLoFFwWZIaa8H3Hu8GdNeLXXZEGs8V6pR9auIIYno4yk16P7r?=
 =?us-ascii?Q?XIHnw096pyKoyCeVPKkUZ76jXM/BqRDN+YuTr/hPlj+TDIOTzQsPUQYWq877?=
 =?us-ascii?Q?YEM+n3Vx2HJfjxeILbwAfOHHCKV4haNRHEabzPhY9F1SjgPV6Pdi0CHF3x9G?=
 =?us-ascii?Q?543xWOms873iYQUIvSYlRZAKjYGd+oYS5HF4N249ihSOm0qWH82PxBoPtNjQ?=
 =?us-ascii?Q?9rCZ26SK1/YaJrS8k1x7j/MqoQsrxxUDwNfwD5ygM5B5fX+/VPR3CPUL2MFS?=
 =?us-ascii?Q?+y7WlSSrxIQd9VabTGaWJme4sEzsqiDm/23jpOB6DCiVvDntsMRALJqxNA2n?=
 =?us-ascii?Q?AHdJSzgXaQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 109c1cf2-d2cd-4b7d-9932-08deba2cb0fb
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 07:10:24.4907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8GfeDj/AZ04CUxrHhZUoj7+YLnq0jssbDEmOuMj5MfmXzvtv1HXkzquC8GG8UuguWh+VmxFyODzHsARcF+a/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR03MB8456
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10834-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[altera.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[tze.yee.ng@altera.com,dmaengine@vger.kernel.org]
X-Rspamd-Queue-Id: 667F15C6F2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

axi_chan_block_xfer_start() runs after the controller is already enabled,
so calling axi_dma_enable() again is unnecessary. Remove the redundant
enable call to keep the transfer start path clean and avoid repeated no-op
programming.

Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 4d53f077e9d2..f7a50f470461 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -437,8 +437,6 @@ static void axi_chan_block_xfer_start(struct axi_dma_chan *chan,
 		return;
 	}
 
-	axi_dma_enable(chan->chip);
-
 	config.dst_multblk_type = DWAXIDMAC_MBLK_TYPE_LL;
 	config.src_multblk_type = DWAXIDMAC_MBLK_TYPE_LL;
 	config.tt_fc = DWAXIDMAC_TT_FC_MEM_TO_MEM_DMAC;
-- 
2.43.7



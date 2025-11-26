Return-Path: <dmaengine+bounces-7350-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D9AC888EF
	for <lists+dmaengine@lfdr.de>; Wed, 26 Nov 2025 09:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E28153B325D
	for <lists+dmaengine@lfdr.de>; Wed, 26 Nov 2025 08:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE1B3191BE;
	Wed, 26 Nov 2025 08:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="mafdyudw"
X-Original-To: dmaengine@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CA22FA0DF;
	Wed, 26 Nov 2025 08:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764144409; cv=fail; b=CpEYyOctP4BR3LVL6Y/Yc6RKF2lebSJ0CqBXdcV/sOOWqlQStjs5AFZlzCiHiP39Ao7oWme5m5y43d/YkzErC72uR76yjyD8HntEokomRrBt+ZUk0GahBgyF7bgKlYHIKS6AoTFkvq9Yy5x0vqkA+5bCRCrF5TTiV0KOpn7Oqkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764144409; c=relaxed/simple;
	bh=nC19ykgebyVY99RVk7XUEtW8aqk/YWrL6RhncS2kU0I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d/Z31lghYSOaFvj/3YrfCwDsW7BGZiZlmhDFUfRczlJOfrJTpIuqt+OhMjbZMVvqoSjXOdNNhcNNomvIHIOcJAZOpa7HZg7gsRQmfM1NbaH0DbbzJYqZBlr8ciJCV6rernGFnEkSpISwyiFSwDlClb7nml8OgOAtex2CLUF8UfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=mafdyudw; arc=fail smtp.client-ip=52.101.43.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcdSBhMLDE4YebUU7u4aRCo0r/I7LjBCV6t5MkDEQlaSpuW9v/by7KAxvrns937JIknpXmBKke9KPoWsj2s4vcrz7ZE7dv8o2OzOU2kpYF+5Ewbuth0yDkszzxqVmb1DpyoXpemY3qOgEkrmyHx+hr59yk7St0MXm7RrzHOvkcuWErufpxNtX8EJEwfX1lY6EaXCwMOW8bpWY1JsVZpsd81JZ3NOdeKqth/z6NJbSb7dSk077hjdc7kZshM75/jZ+FhIhMcwmN9BsEbyHdSh1CfpQq/DPj428pUFl4OhYYKGN2YfQv/9ns/16weYSOCRvHazE4vNAaF2JRoTuxCpUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWLfk18OrPXoSf4jMFfJv31jN5Mcaqg2ZQHNaGuZgtY=;
 b=KBVkwY43QA2ex2FwxPWNsDYzb3cOHTyqT6NkQW+yKUN2mIO9nfdIDj/pouE7C+OUhEv9I+oOUaH+uC2xEaOFM9AXooLgdPUA6JTdgb6JYRof9neK35XN3xjUy5rXfkevJDV6z3BCtdWcVRsW8qwzbnimMhNpUo0EbnzEVA65BdzPz0nv2vb8Gg9fQ15bceWxdZ5IZlG09xXevSJUx/nj0BOgOI7yz9uIRI8RC28ayAuXZ0m4aiaE0tYMVsjSYOvWedePlSF/LRROp+fF48EG3Dl2MNWxQTudmcpTliuwMBZ7ujxkVgiIBOClYiALgOwpokm+eFt1MROq3nNFMrvm5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWLfk18OrPXoSf4jMFfJv31jN5Mcaqg2ZQHNaGuZgtY=;
 b=mafdyudwOMSi4IOJ+xJv+VAk3l5J6zHyK2ZuZsNgSS9qww2PUBWSHphQsrk8KvywN1ffWpCU36JryktI9NGi6DP5GhuL/tb2yyS0OG8TK5+oG5Gj1BmMerIB7pMppKIckhs4ANScf2ZEOlCe6rQ3s7IOaBlST4NkgIvKHuwfBdq+zY8N/uEWx5xuxtobKFueAaZ9hgJB9e+8Avk6hmF5UiW/Ts84ezfpFp/j4OEI/dJR5t6zJOSh2ZEAwSQNcdC3b3CW/1MgnyYC6vHb7jJXFSXCdXVini/PskQnUvgFoQ4W85IEa0aBe5sc+RqKEE84SuubJ/wqk4rzaVG8WhxoCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by SJ0PR03MB6581.namprd03.prod.outlook.com (2603:10b6:a03:393::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 08:06:44 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 08:06:44 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH 2/3] dt-bindings: dma: snps,dw-axi-dmac: add dma-coherent property
Date: Wed, 26 Nov 2025 16:06:23 +0800
Message-ID: <53893e7091f2f7b65841ce91c080eaad66723e6d.1764143105.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1764143105.git.khairul.anuar.romli@altera.com>
References: <cover.1764143105.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0202.namprd05.prod.outlook.com
 (2603:10b6:a03:330::27) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|SJ0PR03MB6581:EE_
X-MS-Office365-Filtering-Correlation-Id: 93981bd4-18db-4e47-4d0f-08de2cc2bd3a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?50QkekDbopE7gi8V3AvrzGtHok82k90LhNm/03bIspSfz8MLXoDds3MTOlvn?=
 =?us-ascii?Q?p4L32/KIdO5/L04OXYhO6veIXhS8u+pNkviNCllzrsnUJHWIUGVLp6GB3JrK?=
 =?us-ascii?Q?SqgGOtV9b9N+8UTY0bEsyql36KOTcOQLECvsh9tQ2WyVzyuzM4QM90P1/e0X?=
 =?us-ascii?Q?Woaj1zdMemSHQWFQW3LpXw30hjB8B4MtEq+5ZqSrl0NtidG2QVLCRou85iYF?=
 =?us-ascii?Q?5tRTOCJlmOfb4nrdE4UgTuMRy20OUlhuUDJ1Kzv0KQGM2DcFM7AIeKU1pHxx?=
 =?us-ascii?Q?hLcales3Q+BwoCus+aqLfJldVF/66tMYmYM78UJdcW1l/LDYqhH6QYKviSrN?=
 =?us-ascii?Q?BPiIx38DCZ7jGwJ6nrBmXuAr0ASnhNB+4XVPpFtEljKgCZix9Rdd34orDuTN?=
 =?us-ascii?Q?JkR2yBPdyeDwUWrKmxUo/G/sMJzt2RmYvZEmBcYWm6MnP7KPN4M21hrXDEwD?=
 =?us-ascii?Q?LWWyQHHe+DpHYRwBW4cPCsNlitANBopQyTfhbK042iMPlLVQWup83xOMH4Dx?=
 =?us-ascii?Q?wUNrxBVsJXzYqlp0tMQNyrun76fL5vITPlDOCvemrloeEY+N56rGb1zBxB8B?=
 =?us-ascii?Q?E+e8EnlaZSwo65DK4X2JTsw+MTyqNPJD5yNMe9nz8OB6NSfXatp+tarXCn5n?=
 =?us-ascii?Q?MyCYuXW5/06j/3NtxhFrrIMb86Wa8rPeyaH32VAVuiaZsKWicv/LV/AKsb+s?=
 =?us-ascii?Q?xbRNJBGKIVLEoHS7GElD2kCB8mcWi86sRvf6hpe3HV5cVFYfqKd5u8kai40V?=
 =?us-ascii?Q?GdqvTW7Q3a9IUk3EW9ylk8VfFLXtJgxU8RjhGNrGKefvYp/kmMmwoeQEHvBA?=
 =?us-ascii?Q?c6enRxoOb5O62VqjT9vHrQW2bAdME/9ZJShd9ChYK+R0+MCCAKaxwG6ociG5?=
 =?us-ascii?Q?p6U92itCQtCYYCohhksLewxMUU4ujy6rOj7jmswE7sOT8Xj5x2uIYLccbnbg?=
 =?us-ascii?Q?uC7f/5SgSDOegEfduXIkt5VwZwBkN1KQdVM8AqY7ZMSaIhDa638h0CSHryLh?=
 =?us-ascii?Q?0AJkSGQCPkDPfyI1YXQ8mBcUgOwInCWNGMSLVYqG+oGEzioyLRdOuYbfvKLO?=
 =?us-ascii?Q?uWNmNxHBf813Ngu4wLxrlGbZsGH/tBKDqe+BDBqqTxRjS3oW8PXvqsehKjCB?=
 =?us-ascii?Q?UZNnbGu/U4EJqSRfNpnw6xG4iID77E52Dm2+AIyPYgFsLB+2HsDq88TL+quz?=
 =?us-ascii?Q?Yywyws2dER5ccJPzI6+ujEpcXqlnmUsKzC8Tz3rfmGra+8XIt7wdT4GnUcUp?=
 =?us-ascii?Q?8AQkWBIIsbTQlb7ssBuxf1ck3ffg20/YQBfjxFH0ad8K6Vp3i9sAEePcJdiW?=
 =?us-ascii?Q?gQmsaaxJesWMKpPh1Rwnfj6Ker0sUrSJSaZ5Y9L9j9J/It0Hu6lkmY0IwkvO?=
 =?us-ascii?Q?Ddnvr9VUUEOAVny8FiPPcGoUCuWqw5XiZPXTx7gJwxMXpawxizLTf5uTdRez?=
 =?us-ascii?Q?E34qBbLDpt7olmE4MEiP5VfoDGBZHbM9Ls3dha6AZGu/cYmE9TFgOzFZWDB+?=
 =?us-ascii?Q?PN5OuQCnvw3jIJs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a/jYs1KSTKn1vF+o/MMYrr19CHxOGYvRo66rKNefgKR7VnRQmkrjurozADE0?=
 =?us-ascii?Q?rVOD0BOKYUE+5A7Tq3D15v7DkhaYOdACWcPVGlBatUu//lqj58rKVYrEH7fy?=
 =?us-ascii?Q?xPP9htwkK4Vic5za6ZIQqmoCB18LJ538nxehKVcMUsv9Aod2g05+4LdqSz2o?=
 =?us-ascii?Q?C+PvMIfAAcPJgCwkT/3G6ftlRM7Nx5Oi1g8FFOooopmJCTDSLF6n9RU5CDvv?=
 =?us-ascii?Q?HOTgC67hZ3jzG8iczc40v/Adzp/xNNfY1V6UaAGVK5IlBQu7OTobJQedrB0t?=
 =?us-ascii?Q?JCGj3B4HzAOhuKzhH02uEJocUTHr5yuVlDGLxCiSPRNBhs1hU47LfP4QDsIE?=
 =?us-ascii?Q?29c2IexlBPxEMdQnTkGbLfnZYZZcywb528OoURag2nA80+dCllEmfr4L+8DX?=
 =?us-ascii?Q?0OM02CHaSNw22ZKkt8Ke5oJ3f6Htjnb0RUxZJCqF63X4AZT4a8G39dJmyrFc?=
 =?us-ascii?Q?FaUDNzJx4dOcHu3auUHmKEwJAxMW4BIaFeZ1AOIDR2nPpNs/vEZ98AzaP9MB?=
 =?us-ascii?Q?2CmJoicJ1C+6URBSDkxGKDKLiEye0+3LaQ3PV+W3/e9SOVXeDeB2PkcLrsT7?=
 =?us-ascii?Q?F+VbZZ3pRwYVpxdH+z6Q+P4mS/1He678oUrnsPkLCINxmLBUOf4myafOWxpo?=
 =?us-ascii?Q?z57Vv9UUBBfj+PUSk4Uw+2BsbrsQE1wyhxVsAVzAfadi7yjgxntR/er/nTXc?=
 =?us-ascii?Q?jkhygDnrOeV3NoVhAkPwJyToGqNW1RvYwRYUIPZt7SY/nnQyVwhVRahuHd2U?=
 =?us-ascii?Q?sdoFffumFYS2oRD2sDaxQ9bBpQ5QXlSxpMKRPC9NY1aI1T/ry+hEeLMVhYBZ?=
 =?us-ascii?Q?Gj0UeGfEwNy8GU7/2ycoFywhqh7Clyqn4b27YQUgsSsTxj69FGbv/bwazdeK?=
 =?us-ascii?Q?4LmRIEMsdcSBHgE9jtsa4xcaU6rHqnqoXhhJOaJJsDaU5xQIq0+om/hhdkj1?=
 =?us-ascii?Q?Dg1RxuR+uqAbSp0ByKUPHULL0DZT2ASCSXpWssms7NEC3aEfqHK9TimuQyFH?=
 =?us-ascii?Q?srpvR2nTPgIzfflpB7Ik+4fht7Tmat0ni0rkM3/eeghze18eDcMl52tit1TT?=
 =?us-ascii?Q?BivPTlxLWKLH5u2bgIZOGKarnJa+JGiA6WLPdCvWz7VTUuEwSjLZlW4EQOUH?=
 =?us-ascii?Q?vqcVsY2FIKgV8oEKxnPOz/IhXsXWneql0coVGMl3ad6vmVhwmxwrSOWs9jQF?=
 =?us-ascii?Q?BSBdUsQEbnVac5Up6eBQg6P0O45KaLMQfJ/sm8CznqCxH/fUoPcPv2VjhXV5?=
 =?us-ascii?Q?KnwDPjWmtq7Rs3SqO0d/F/pKMKZ2DVbHnFrnEzf+DVCJ7oR7YJ3S0hQ5sS6/?=
 =?us-ascii?Q?RPpQ/mkdQN6Dk7ZAMg3qW03BIxouQFYMin+V/8QJ9jmCwGww0nwGuOPw6sfy?=
 =?us-ascii?Q?n9e5QAi6/DhBBRr7YRfPSVNyZ5MSB/15b5nz5a/WaiZdcToJH8bOR3RP9mkH?=
 =?us-ascii?Q?IP7u4/tLuA/hlZWeVS6JMkdodn7l4kiqx2ttiJ3O5e0YIf/WpHw8FCWwg2j4?=
 =?us-ascii?Q?Wm7AFhBUsYRcuSGeBFyJgqsRj4jthZ386nOYYDhxgUWyGDQNIO1KrsuydJYr?=
 =?us-ascii?Q?hJ7uc/tzVtRVqK3LhO1xVhonB4J0ThfWyslssjxCNxSZ10+7okq1Yq7RO2Fi?=
 =?us-ascii?Q?rw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93981bd4-18db-4e47-4d0f-08de2cc2bd3a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 08:06:44.7833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PXSI6JuPdysRsjbbP/+1oEyg0n/7YjXEfnpxdLmWqfHVFvc9OKy6G/ivfOHCtyB2IfWuFZYCwbcZ3K4A8//LGSmiYoz5AenrtmHbDcaYHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6581

The Synopsys DesignWare AXI DMA Controller on Agilex5, the controller
operates on a cache-coherent AXI interface, where DMA transactions are
automatically kept coherent with the CPU caches.

dma-coherent property will enable operating system to performs DMA
transactions in dma coherent mode.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
index a393a33c8908..eb67348b4ab1 100644
--- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
@@ -64,6 +64,8 @@ properties:
 
   dma-noncoherent: true
 
+  dma-coherent: true
+
   resets:
     minItems: 1
     maxItems: 2
-- 
2.43.7



Return-Path: <dmaengine+bounces-5192-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F17ABB45B
	for <lists+dmaengine@lfdr.de>; Mon, 19 May 2025 07:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13E713B3FFE
	for <lists+dmaengine@lfdr.de>; Mon, 19 May 2025 05:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D9B1F03FB;
	Mon, 19 May 2025 05:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="bPsfGx9p"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643E91EF393;
	Mon, 19 May 2025 05:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747631429; cv=fail; b=fYjGMqdMLx5CcPiILG5O9Rx6OA5WlXlL+w0zVCiVS5hX033waA2bowSc2dk5GurAkC1m04AcnBPCoyYlhXlTHgOQALq5u8XoyC2lOwe3aIbjutmbKhdpX2lNgRRk3npxmpxasp1EUdMWvJaWnS73Z3hqRR7IpzeHsz/YPnWpfqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747631429; c=relaxed/simple;
	bh=7+M8VIpe7BNEhY8Fws3P7AsbFSNlv/IYhvsxkhSVEvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B07kEyFthpEcE0iu8qzCWGGc+kZoBt0fEHCAXb5DJGWBdx8GR2ZAdGa+4xWx+jB1Ud1Jx4bYgF1sLOaa8q/bTL4CQUj+vk86mzYpF/oPVOAbsIxdwLN0EPcfJTLWAZT7MmWgNPow/Z+iiqhGsmCCBIHhxBAyg8kA3/k6NOyCoHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=bPsfGx9p; arc=fail smtp.client-ip=40.107.93.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7iGMPhGe/6iQmlXESs0AeYS9qKdoT8qGEb7QIWrXCk49CEW1AG1VIiAa+fCEtXxkuE7FcRzBhKKkBi+E3um1kY1hG1pVQFsK0jvSiLV/XzD8SesnsXIrSr4NMdCVlw25vnZz7Qi9V9PZFqkXMq0c7nw3MpTq/AnJJVvH87HtR5JeTeRXhG37/3qgEkosOm4Qr/U89eK1iK87ONuwqDFcwGqKF3AgeCmYPCItbDTKzQ+vdfGTMNfZypWjxRBV2qaA2SDvf98fMYrTEO2fHPQcM2sE/3jQJcHQ9u6Lw0m27YuUEr+iG6/jFy0pME6EWj9GDJFYrF1rFp1Wg5v+2n+7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KG1yPnUYLTj7Q4FEDXtugyvdqH3ixK4FiYSzV0b6A0=;
 b=bbHh2mz10gZTOMe5Kx6ei5zM23lHHwrpSqvRLUotVNYemghOdZQlmzRHBgqGjN8ddk5/eJowdyJxtRzrncaM0gSX2AtT2GRhh1Lk/xpDbWUq/mGUdmArAMPFzczge/Gz3hPvzrELRNdciUzzW4n43TCXK+8ftelG+APBfmTZRgSmSgCg6/FGkD1bvrEbfHcRTlG4mihdRKt7DcoQMZvvJTMmyNbsvd4wq+B2gJ/pZkBbh393Hf96cYOcZLZfQLc+3uRDMoZIUpBC//vH1teSFZyOfGE70ZyPh5SaMYudwbodFhrK4bmNAsUKExTzsmFNj46cAKH2wBTgBYwoe6uD1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KG1yPnUYLTj7Q4FEDXtugyvdqH3ixK4FiYSzV0b6A0=;
 b=bPsfGx9pJNkkcwMudC3pvuA+J+1+0mqs7sR95fj6d3Yee/hpFtqAXjct10g43wSp4IO9kMbq5vgC1J1L1Gtu4PbQliSCJAjVMtkVhG9LFChgfW4ZebLYja+ziHtZXJbDD+/wwP4oWcbxmjmWwY+XG7LmIjV5VtDVa+NREpqshcAO6zEAO/y5kQc6tBqrhRj10b9URRZpR5iKkz9worKIHgiNnjUsJT5Lc4utHXRNmK7Su9tXytQMYOGWPYqXaOzcrk1WjxJWD1yGOgu5Zkn+ESfxz0X4AENlDpEmzphnW5ZOhXYZuPL4VOD2leKgqX731t60vNUKZfKmFU5bvq7j3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 CH2PR03MB8060.namprd03.prod.outlook.com (2603:10b6:610:280::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 05:10:26 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::c297:4c45:23cb:7f71]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::c297:4c45:23cb:7f71%7]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 05:10:26 +0000
From: adrianhoyin.ng@altera.com
To: dinguyen@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Eugeniy.Paltsev@synopsys.com,
	vkoul@kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: adrianhoyin.ng@altera.com,
	Matthew Gerlach <matthew.gerlach@altrera.com>
Subject: [PATCH v2 2/4] dt-bindings: mtd: cadence: Add iommus and dma-coherent properties
Date: Mon, 19 May 2025 13:09:39 +0800
Message-ID: <2fe75c0443a8481d80a3cd05a6f3ef2ca30eaa97.1747630638.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1747630638.git.adrianhoyin.ng@altera.com>
References: <cover.1747630638.git.adrianhoyin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0114.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::18) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|CH2PR03MB8060:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f4257c7-bccf-46fd-3708-08dd96937759
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rYjNiO+swxhWffBzptgq3cRt1VhtIzREDpagM4tIYLQ8KD2FIoRpfXKKtf92?=
 =?us-ascii?Q?X0j5x5Uth/749c4NKwyr+P0WaF3qvacACYhEvFhciGidQYVVDs32fCMXUrtJ?=
 =?us-ascii?Q?EaSbaXTJ1DOzwSuu8mFwTK5qMRAJ1R6bhKI32mTUtuN2WcTbxSDF5TV4FdCr?=
 =?us-ascii?Q?aQ34UEXXn/os/jUgaRy7lnqqvEMlWMu2E8l5upzvwgR6b5wSxhPjG4eb9tTb?=
 =?us-ascii?Q?k7WakYq/kupwGwOh51NMyS5eGXrmBXDJfAVMh9AZvoUZnFPpZMoP9lWbZnlj?=
 =?us-ascii?Q?7LSdsX5tENd+xg7wy78mERLWV9C/mGXa8MIgfMb/lX6INjJ/7mOrdHMYuNXk?=
 =?us-ascii?Q?n4fJXMpTmzZI6obWXA3TKHCmo2T5S1fEWFICbTMG9cK00juwvkAxfh3OXBeK?=
 =?us-ascii?Q?0eBwHCJk0K+TWmjdE2RshUVAx47C5t/0CHgh7JDO1d7s+8jWL545WXM2v3DK?=
 =?us-ascii?Q?aecIQZKMdv2n/XaYeT6KbF0TDlpFN58hWQuCitnR0F3Uewl//xpdwtHnUnLG?=
 =?us-ascii?Q?iODgkk9RexkNRyK6q+vJKPedDKzpE9jvCzRPSIvHHg3iw42/BliwzGdc/9el?=
 =?us-ascii?Q?KHSVqp4O7HzUuHQjjIMtpyc6c3lxbiRngfhnYfkCdjW6PI8xGTPk9JxGqmke?=
 =?us-ascii?Q?xTxgcfchIbPeRN5Na/8D4bdvkspmtBOtoS7RBnsxQ6aKsvoj22W7IGbQpuae?=
 =?us-ascii?Q?wAZ88qCw2cISbwVXmG1Vy4MUBW6sT2N/bzmtsLQTMzYz/ZFoqkqWGBeYMDCK?=
 =?us-ascii?Q?hOAcJ8hLCFe2F1btVIE2VTUU4dhH++MUyo3QD/GSynsB3QJD1Ge+sAJagHzJ?=
 =?us-ascii?Q?S78cV/8x8dOTc4dHNb+V90B2pP6VHCdvIBy7t7oTBtpe8bm5kxoIt3l9z/pm?=
 =?us-ascii?Q?6sLsG0ri1hGMbPal2A1UXa8F9t4qMHcE479qK10OJMxLAkXiWWMO2CkBHt9d?=
 =?us-ascii?Q?/f1B3bu4XrU8ovOkqwM895PLZE+YLqt5Ac3aO9pzBox2IzY8OwTk88o9o4hm?=
 =?us-ascii?Q?K9Hmaj8RsNB8B4JRQf0mJZBUcY7/CGgBomwafhm0qvexP8Tjoqi1YnkQlNAv?=
 =?us-ascii?Q?7yGq7atobLYFxL4zQKVoSRG10VLzWHyFZo/p3KhJpsmtcZiE+pC3rZOy+Ny2?=
 =?us-ascii?Q?MlFvHyUNU3kXI2PciNechtzntLYkeWjAe7K/w2yEF3Ti/CMQvEbdFRtAICPh?=
 =?us-ascii?Q?aEg7U7aABzYksGdtDY5bqsU/gQH5lnqPR+t+kz1cEag5VC3Tb6XVMb25mlzf?=
 =?us-ascii?Q?jCUn/zYlnu1j0cp+kW0GI83Y/Sv8u2PV3XroSJJf2lyJZV0Wu8aWRGNudOgU?=
 =?us-ascii?Q?VOlId5O87syFVHLaioBFzfnUQ3gVBO1Ei3a5+0stPwtxCViFRZ4UyBVlBV31?=
 =?us-ascii?Q?YhE1HDIKy2XTcgaNzqNBRel/TzEzws9O8ilWHtauHP4IWRbzL2MZYSS/U3+n?=
 =?us-ascii?Q?txSdjGSch1M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1vR+za/SeqQV8S/x7HsSLYJNbiOJXLHXlnprAB2fzJARFGB+4PDFVExcVQzE?=
 =?us-ascii?Q?GxLDoFCqgPMwJShGFdZdiF0wmz1ssDTxNfQXVZx+LN2gqzD7KCvMVkwd4DCy?=
 =?us-ascii?Q?CXik26mSVdbBqqAUYppa1dGxzX+x+3T6bQdIr0aKyOoUpsEeKotJFBAqSB3L?=
 =?us-ascii?Q?kR9YazW2ICq1PKI0z2OKQ6/vbtaxu7mdQRVayLSZDP5m2mdnAubE87t9Pm9S?=
 =?us-ascii?Q?++eQeDRDsauYfKTAIAowvXYTGUZfHdF/t+6CrCCSsU/U+22qekxwC0nujBtC?=
 =?us-ascii?Q?LWHFrLAxSPmHsFjcedo+GrS9ohKlU1+TftYu/AAoTolUIGATfTTDe73Y1h1v?=
 =?us-ascii?Q?+RDfgp0kocwSDy1/Td1xheeG6mrlaKp5Y6fDw/FzqCST72yGBz3yHu9S55M6?=
 =?us-ascii?Q?Y5hTb+2drQXQ4KzuhIMAReg31TpeeycYX/dfbGrD4OOzsxa/isEGzuoI9lAj?=
 =?us-ascii?Q?IX1xnT+jXNprLPH6rcwxttcWmvrEWAAAjiyRLlIViQr6upx6tyiOgPvu7IGO?=
 =?us-ascii?Q?rADjucvjIs00Qpi2nB2o7u1arNJeLi0MdmCTllOIRAhO1ysswyCRBO6tI+U5?=
 =?us-ascii?Q?ai8sfx7UcheNMkcezfFqO1sNMpp++7LSXA+SBM+8nVdDPDfPqrkmLPAKgmtX?=
 =?us-ascii?Q?fW5wZ/YJ/5z0dNrjS/aGRToUdQ3hHkOvCpaLdfj+oh+T3oAOQGMwKvOfyx01?=
 =?us-ascii?Q?HQQhqTFoBaWCjc5jBLgGkhqNg8vqbxjemnz8lgkbux8Qy0D+h2Z4dj9TkzLP?=
 =?us-ascii?Q?4JD2PteoF5jXu8GB94mG3o8Pu3WEMdfi8IOv+SJmPmaId6MJ4ubPWvVUvnT0?=
 =?us-ascii?Q?tdKvq/DNEAuzGc644YT4t129MR2X0MNXZR3FoTD93ELVrmfkBTwQZBafzrw3?=
 =?us-ascii?Q?KNUDRg4VYKXHsVXeF+rdAmjf3ldSRdF4FiqnNXSitcwlsSAwU6ncv3Z+vI2j?=
 =?us-ascii?Q?9ks/5MP2vBT8pcL/jyy0HT/WmA1dzdLMHx67VeO92a7k4ZBnWRRvOYay3wQu?=
 =?us-ascii?Q?DeiOXQHI36vFfYlmesIIfPcTyhiN52Tngoj0arC8BeAYKZNGUxWDJDr8M4Dq?=
 =?us-ascii?Q?w3teEuqC4j0ngzZNxlBQMMLBYaEnNMnzpPR+1UvHJo+o5W+Ive/ouYGCsz01?=
 =?us-ascii?Q?oFARLDvT3AWaS3oG1RlByuM05bOYWd+F4/wGNbL8rPOnXMDhJRGlzOVesCVt?=
 =?us-ascii?Q?tMm1PKEJWDDLhFesFq+og7ud3fOYkoF6WY+qbBe7xUQPQ5gI7Z0JyQaACvfr?=
 =?us-ascii?Q?nc4Ra1aDgO0rPzTFBEH9TYhjsVrqHWyuwhhDosUYb53OM40vbjlD8MiHnNVa?=
 =?us-ascii?Q?JNvqdLQzX4gx9/xLcMs9zr3NSRBiuLoDaZtdcy4jm7zPnBv2wRPvha1Pnujp?=
 =?us-ascii?Q?DGEHum/fXFR7IwLBgH/o+MLWd+vMlErokDCWgspvDEZAPUVvbgUtQ9hucVZA?=
 =?us-ascii?Q?JwblTCQVEMWvb4RW8pEjcYbrCrjPnmK0TAwOXEEgRWBwUuw+vwFqjul4VTE/?=
 =?us-ascii?Q?ZytlEAcsgTRw5akHf2bJ+uwG7eNIMPFm+EezzwoyttF4psBYpeGsa0JmCfwt?=
 =?us-ascii?Q?RW5y47w+CaE1sK41IDboAtlu33xZExXVZ7O+SPGmktoVagyyJqHmRcAoseKT?=
 =?us-ascii?Q?LQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4257c7-bccf-46fd-3708-08dd96937759
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 05:10:26.6354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IvX+c9o4NtB8HoVA7w4Rki1xNYOkW/az7NOMsd475m3CySRwYUNf+aXFLFZjg0y51k8ZhItSWYRFsmTEvBD4O75MHsbiWS/o5EDPvoAO1Xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB8060

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

Update bindings to include iommus and dma-coherent as an optional
properties.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altrera.com>
---
 Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml b/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml
index e1f4d7c35a88..367257a227b1 100644
--- a/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml
+++ b/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml
@@ -40,6 +40,11 @@ properties:
   dmas:
     maxItems: 1
 
+  dma-coherent: true
+
+  iommus:
+    maxItems: 1
+
   cdns,board-delay-ps:
     description: |
       Estimated Board delay. The value includes the total round trip
-- 
2.49.GIT



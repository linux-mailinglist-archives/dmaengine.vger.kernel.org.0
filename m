Return-Path: <dmaengine+bounces-5184-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C60AB9522
	for <lists+dmaengine@lfdr.de>; Fri, 16 May 2025 06:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CE903A775A
	for <lists+dmaengine@lfdr.de>; Fri, 16 May 2025 04:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D20422F75A;
	Fri, 16 May 2025 04:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="BMrqwinG"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11010046.outbound.protection.outlook.com [52.101.51.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C081722DA06;
	Fri, 16 May 2025 04:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747368392; cv=fail; b=Go+kUWo6ofAG49xA2s+oOSTEP9YjjNNOG6WGCnds6/PPyMauWRJuzlg3uit1bHHoPLUag9gNeGJEzow9hJ30VhzTr0XvQW61YXTkGLdSY3MTtig7kZBy/Ft6GZPqz2jawmkKV+8b8bKPpIkmOK8CvayYgPzNg9ISZyQu+MbL2MQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747368392; c=relaxed/simple;
	bh=TFPi5kjkIsZ3se/aGjCsR/Lg7t2USkei9dbjnIQ2evg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pORsCBsuTcvOKUNeyXjHxkJeXPLIN8nfH3fdNIVfsmpo4MIGNzCzrucLnioMnzIDexIPjJ2HomFXGePEeDR90pX6nkh69cm2Ec80c9x2rkJ3omu0M6oMdbOE/fDNaj7QW0UIpL1pXdowz46WxXQU18pm2olZaryf8+m0j82iis8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=BMrqwinG; arc=fail smtp.client-ip=52.101.51.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8ODWAXyxqGuJXfRdYou9h/ls2Y4sKcY+y71iHoeE5P6BaJuZHE2cicCtmfyGnj94WFtKWpGrjXVHSRRl1tBRaRnWbl04Sje6NS5voZtnkOi5ZfGx15i9vAr1jYQDenV4InEmbSQHtydZdRt8P5EADUvzPYJbpDdlALKGfwySI9mq1vvezocKv5ebFnfIGrDhNK2L8OjoGHl/kWw+shds2RQp83svTXyzF5eLeaSVxIshagBaupVQyi8CVAVgqhN9C92JTy4cuW0cj5CcTujcFN8oUV4M/lxYVqWYXcmVXXuK6xx6gfCuF61bKHwtRwcBoccQYsuvsONNVCWVudsBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7e3BShKtAP2T6zVxx/3RuZhhXANtyhiWu2E9EW7ct8=;
 b=Zt9TTYoxCwHbxPVpkWkDBWO/6DxYf+iNdTnKMYVK/fNLqTwbTrjN9p9B8nOq/QuN1caIngVsg0sDsyWbtxMV4D6c9U9b9OMxFPIhnF0OqKNNT1f6LvMtocv+S99K9GkUateMPM4A9VyhTLcMZ3POR/5XiE4XfXjHQr27swtO+PvHAQqkDgXW8WgvuUnZm0BoHaxZPfXBCX/elMJH8Nc8+94tuc6mXflV3HeD4S9of28agTV9JVHU7ROkngN58mICYa/bMWsgKtLkWF+8rsKLGIk5Bg/nOMVb2zSiBTBZ3N7cGlukkWXGDOfYubt7envbVrSX5w8qPzYlc8JxH1Ih1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7e3BShKtAP2T6zVxx/3RuZhhXANtyhiWu2E9EW7ct8=;
 b=BMrqwinGGmUSq+PP56+kcJi+9yem1ZpZPtS2D82OuskyjasfvtG9riWlnchJrfuEmMEWdFwkenTVIRp4qJamHYDhFPcFT/CePJjA0MjCT8WnCE/PkhuNd4RrIjPGmpTaG1G5IIyAUj9fTpz9X0+r9e0/rQFBUCf+w1fJuC6DHHsGgdEz1NjZaJWVBhckcjf+jN+3Fhe5M/s74Qg7YcUs33TuPpL+THVyDZ4/IP5IqfI37k+KCPbnQA8/+UMfRMXuD7NHJmaR2O1MDBF2PFWPQwlYZ7fW82buGU66GP6yi4w9MnNp3J0Gy8XCG+rkp5/Xi1yrunxX6GCSvh/0tp5KNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 SJ2PR03MB7093.namprd03.prod.outlook.com (2603:10b6:a03:4fb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Fri, 16 May
 2025 04:06:27 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::c297:4c45:23cb:7f71]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::c297:4c45:23cb:7f71%7]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 04:06:27 +0000
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
Subject: [PATCH 1/4] dt-bindings: dma: snps,dw-axi-dmac: Add iommus dma-coherent and dma bit-mask quirk
Date: Fri, 16 May 2025 12:05:45 +0800
Message-ID: <c9d1ae618b43b328b3b8775334987e5acdaf2490.1747367749.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1747367749.git.adrianhoyin.ng@altera.com>
References: <cover.1747367749.git.adrianhoyin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0126.apcprd03.prod.outlook.com
 (2603:1096:4:91::30) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|SJ2PR03MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: f44cb034-e396-4f77-431e-08dd942f07e9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NKgBswffqC/Xum+7xF4HMcApW9rddUXvAGhmmRGf9FUmmceH2py9OKGBd9aF?=
 =?us-ascii?Q?u9zBKhHJa1PuARw7QbzcPaGajSl28t1Cd4ug70ee2VeZVZ+NHkpJ1CF9KRGI?=
 =?us-ascii?Q?pV1IEm8djhosUjRWPrU8CCS/MZiHTfPpnYcOS8gt+ThQfgZATcct34r0sdvS?=
 =?us-ascii?Q?pvaC8RvyJr47jJ4dZ095RlCiw1hKLS06DNOgzZ9/099UT5ywBuzzWqOOvl2Q?=
 =?us-ascii?Q?EbTUG+tOy/RvLsoeC4jVFSKpPyuE3GbvclUe9d7gs/wpVdCRBJ+eVxN+0S63?=
 =?us-ascii?Q?w5AYMp4QFgT/c6KKLnhF6u4xiFIzfKs9MiUjVQWTKb5hgXdXyKCYY6EQuwJR?=
 =?us-ascii?Q?gXnDMHhiex+q4Y/gbHP488UuT+bvybAml6AivZ3AbXfkC9A4/IdJVJZZavYU?=
 =?us-ascii?Q?9YeVkH5/QOd759t9BC0GD5NPIvqt8PFXxJkWfILUB342CWnUheR/oT2mjmov?=
 =?us-ascii?Q?jbBqoYuncJoERYKcJFKK9Co7OcR7y2evruake1DYzS8T9PxBKp+rMS3czMna?=
 =?us-ascii?Q?e0kcn1ewPZOhJy/Yb+V7AXFWB76ibDJ3YH9icKpMSu1rnVPQ8fc6I5DvsKUk?=
 =?us-ascii?Q?YvrdpbNVwVcN/0f+ziRSkD6/1dVzjBtXhIKxeq1ykKxKbJJwBMaHc5xTDAYF?=
 =?us-ascii?Q?q0ajx3llOBLwXUt8Ib57MoQuAegYEvcKqk17Wn72u9TeIu+00NNqTlfV4jgC?=
 =?us-ascii?Q?2g+WmH8eMsR0sEye/wdh+YdAvlyWWQo9NsoPJo73H7xJTdEaHaVdJsvy9aP1?=
 =?us-ascii?Q?nyAX0pjDoo0eGNuy+Z+DLOy024/JcbBiVXBvTlL8druSRGDzwICupZ9uSgA6?=
 =?us-ascii?Q?rwqPKZdiTHeCIn+DBYBM3+6jiR9lpCuQVvPDSiZrvZbkeVwJiYOI+Wch5wUo?=
 =?us-ascii?Q?GmrhWw7qERie96/7JHmPXTCHTkfxvimMNzaURqGc0vztVPFWADCViRfFIxJx?=
 =?us-ascii?Q?Or3MPeEd/HUHOWmOE/wnVy6noDKct4SyOaaMIDholaKc/xbfi3VFh88qA7qY?=
 =?us-ascii?Q?viI5Ij06//+h0k1hyeuhq/eSZQxEM9zv8bAHX0ohW6venCjKPHuY135uGrHN?=
 =?us-ascii?Q?ZHe5FP2Ga1zJaEZemYVshVjj55UhV8kYwxKP+0xVChaMx3F3tRfgIUnhZ+9f?=
 =?us-ascii?Q?reHupVp1pYugpGKK1gCVxzU2f1wDSpvJoAtrT9Tdux8ZN6a8XQb+Li+WZxDH?=
 =?us-ascii?Q?EtboJmwp0iiPcUKznohCC9Eu7wtfTLgKkkk7BjTpd4AJM5jJRnnH1eG6E2MB?=
 =?us-ascii?Q?XpormX3L8Bi2S+oDw0YW+JVda9pkafJjqwk5ODs0YIfO8ar9Hn9y0OVJWm8j?=
 =?us-ascii?Q?XALzF0Kyw5jtID5nH5nxWjYdHgL/KDRzk17rFtt4hfmRCg9GgUw9tUgBnp1h?=
 =?us-ascii?Q?3xE0BoBvTddgDRKOhGKR6p0bF5hlxsWpT9jk5iqu7DQZd+zECZTfGduZDqCI?=
 =?us-ascii?Q?5FVG78HykKQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ChGowOEHwgmBBNCNtCIkqx2saUYa9dhEVDcJn0LxHOLntVA9cffhPOHIPrzc?=
 =?us-ascii?Q?wXTkprtp2Vt9x9+6kGaxs6OrDzBBneoh5IVX8pBsv1F+goM9MivNm6CXEx+I?=
 =?us-ascii?Q?LTR+Z1vRC+2PHZusO4pSF5x3cfYGjj6wFZrgg5Wc44Dn3MwdQvlpKYTe5JzM?=
 =?us-ascii?Q?PS3dWknB0w8Rqa+XyGfWJs+GoMgfR1Z61QiAYYjz9iHznLcOHsBY7nsr4rug?=
 =?us-ascii?Q?10J18Y1r5w2Is+AsXsykZmHpEzjxmMxVFba9zXxVQlXj5aGHviydCWBHm9Iw?=
 =?us-ascii?Q?64suVfv7F+ab7UUhSX0Hx5TgZWQbqNeIKxEhg+UrtoL1HjzIPWcrm7xqK3tv?=
 =?us-ascii?Q?2KZI3bBsnYKp/IIcwlqPmBTbQParGIbzUMDvfY6tJRuJPmQy8TtcHsHJXWjF?=
 =?us-ascii?Q?QIbhouJHxeBwdDwrtKvUlbqg9JF9y3fYSgLb/Mb2AutwNZfqKQ0904tAapVP?=
 =?us-ascii?Q?tyfouLhApoUYixgXd2LSn4vS7ZixDhiQ0QLq7++ft/rrxZmM/dIRWwVDFqPu?=
 =?us-ascii?Q?K+tqIguBLUWhiPNZmnVnw+IyaouDB2Ezl8Cf7W4ovPmjTiUA7oSYGv5pcZgh?=
 =?us-ascii?Q?RCuuFNNNT4fC1oQIh52Cz5KSoBxEI92AdC6Y2EIE00UCWqO2wzZvC6PBovef?=
 =?us-ascii?Q?G4ws4ReYttPl69X8MYt5XftPKuOwudWOVg5OEYtXyCajhR/cB2Rjiy57XP/6?=
 =?us-ascii?Q?I4H2LMdNGLOJ6EWkXj9z+zxXwD9PTb1eKFyM8CK3YsPdhG4ezNMvhxcEArTC?=
 =?us-ascii?Q?Cj+1Gd2rMeqKMO6FLAPMz/5SxBwQSIGtbB8p8EtIEUi68GXUgOId/jNN9SE2?=
 =?us-ascii?Q?4+ocU5+mI3ikX1IC1KD7yFnIQtybA+7Rt4FOSL88WgKjaaZQ//9nMT/PX3yT?=
 =?us-ascii?Q?R0+s3BE2kzHSqSLVvJNO1M1eOGWmMnP5eYd290X3Bl38B41ib3SQXEtaVWuN?=
 =?us-ascii?Q?2iiXW/Iu39PdFoFmhKXmnAZz1H3T5cPhPeUMLPzjK8CvXbCikrX/IkOrjYwd?=
 =?us-ascii?Q?14+9Bs2iX0yzqoLD2PetJ0L25nCF6bf8eC87yUfGdiE+YYScz0PgIeP8vkVr?=
 =?us-ascii?Q?/EuiTMLSmuXJXNB7rCU3cT19y4zl2GnbLywV39rJJlf6kqY0aNlFPoEi4+Fr?=
 =?us-ascii?Q?VrE8JCiXGPTS8MeJGKmYY66whD/NqPh+FshwstAtDQEnesRVdyO2Cy493s6d?=
 =?us-ascii?Q?OTik28gaXV20mt7iktFE3aZR233Ewe6oEzDH/17rSSeMFcvyqxlle4YVqCOT?=
 =?us-ascii?Q?Zp5ozYXXvLRkSCyjw1QC/A0Z25oG3BCxVLnlck3VT5/ugmVSCZraLQuqJajn?=
 =?us-ascii?Q?ei6BFXSPk0Dq1kDzA/vThm7tPQBegqyr5K29wcN3SW6mrJpPAWqKaof8bBil?=
 =?us-ascii?Q?n8zwY+I1aiW1jJA02v6gm1raWcUTo6MjQ1Nbmyhho9lfN98VUwNp0aBSALri?=
 =?us-ascii?Q?wGUC3SOxHqDUm2Wr3AsVxSyKA5EiWpjjqRXPy18KoeK4O0It0xOhS0Cx3VrW?=
 =?us-ascii?Q?BH9HPfjjxx2qybef+2x5O0G/yPCEYvjbUZVvwmVdCy2rUYjq8aKtAF2ojLTW?=
 =?us-ascii?Q?YJH/6K50b5C5PSNpP+a0922BHg7gOu+0CK+bvGzD5mwRJeRn67qBCc51tg/5?=
 =?us-ascii?Q?Yw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f44cb034-e396-4f77-431e-08dd942f07e9
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 04:06:27.4600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xY4WgKHjz7HyQxFWp+Qx+9WSDWoRle1gK3nqdXZPM4/SMbK/oUeeK9qMzBeDqePVqnfYitvkmQNDFk6ONyd8yKZPLaCnduVdLkUOQWNIEew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7093

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

Intel Agilex5 address bus only supports up to 40 bits. Add dma-bit-mask
property to allow configuration of dma bit-mask size. Add iommu property
for SMMU support. Add dma-coherent property for cache coherent support.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altrera.com>
---
 .../devicetree/bindings/dma/snps,dw-axi-dmac.yaml   | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
index 935735a59afd..f0a54a1031e7 100644
--- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
@@ -42,6 +42,9 @@ properties:
     minItems: 1
     maxItems: 8
 
+  iommus:
+    maxItems: 1
+
   clocks:
     items:
       - description: Bus Clock
@@ -61,6 +64,8 @@ properties:
 
   dma-noncoherent: true
 
+  dma-coherent: true
+
   resets:
     minItems: 1
     maxItems: 2
@@ -101,6 +106,14 @@ properties:
     minimum: 1
     maximum: 256
 
+  snps,dma-bit-mask:
+    description:
+      Defines the number of addressable bits for DMA.
+      If this property is missing, the default 64bit will be used.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 32
+    maximum: 64
+
 required:
   - compatible
   - reg
-- 
2.49.GIT



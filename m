Return-Path: <dmaengine+bounces-5928-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AD3B17E92
	for <lists+dmaengine@lfdr.de>; Fri,  1 Aug 2025 10:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D89123AEF27
	for <lists+dmaengine@lfdr.de>; Fri,  1 Aug 2025 08:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9247221FCC;
	Fri,  1 Aug 2025 08:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="BuLDBTFz"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011005.outbound.protection.outlook.com [52.101.125.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB03221739;
	Fri,  1 Aug 2025 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754038142; cv=fail; b=DrVNHsE8KDQZa+IF2lONLX9ReYOUTwlbqaOgd/rz77rZbdkzZ+SUdypmFis+Y9DHgcHHLkHLMemdDnQzGKMcqwiAjo3jL7qao0BMlSIslWn34a/B+1VIqO82FJVIE/G8xvJEP8sGe7m+V1pP25A5LxlrBkO9mp3COs54YFkjqIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754038142; c=relaxed/simple;
	bh=PtSNajD4d4ODlzXMvxmvMM2RmJtD8rMiYHSItQDH5Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CwR1acbfDtVlv1pVQ3dSPg0M6KpQ1WO4c0rrzP4aIkTGxIIqCa83ZscfI3O32EXZYyyKQGnW0vJKdJDY7rT5x2fn2Tb7L1rt2j1W+6s4Om0B50DnShthU685guVXo5T4l+XsiseXyt4tlefhk4T1t4FdeVu9PJHUGDbo5emrPh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=BuLDBTFz; arc=fail smtp.client-ip=52.101.125.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M9+CgHEq2jluxI3FfoJ0Xvd9as9So4QN1XbkSKypF0W5JyNyJPjP8LpMBYutxiAa//tqoW3IaZBasgU7lqjbMOZqZxUf3eFqfm3PXkLB2BAzP8AA4c25vsqKwoBp9IMjnij5WNstwYSAXIRx/ztwCRYAz8AN9fk1yI0z5Wyi8fiqOdvYh8i1OtiUrZpvhsOfmDgrwq6/+sCW26l6+sRX3NVDQ+Axa+s0bwJ8ld78JyuGLx9f4iR14VyREL1iLIENmch1vPli87A4rZv31Qo2Kl7HigQEM2hNcr05Z4uOho6LQ1yDFpJGPga2AFmpvDb+ct8zztLWBnvu40/emAkyiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDijJ4rfLzCpw2g0lAaNccRV95Wk963NyIAgMKVa7F4=;
 b=cmDoAHJte0tDvPMLl8MuO3koV5DvC0Kc+/P/R1yGhyD6ebP15oVjf0BplbX4stL9YQddYAXWI5alGcKWYaJq6BK+UHW6YnnvgJkGzaFQ5qom3CJvi1nWN+XTvvSyyJacwI7uC39SnBxnxguwIrgIMqDPBN/OOCqLO5aRm7WQMMwCQ2CUo9DJoHbFjSqnDrTU0RgeJ9Q9oVVLAshJ4VxWCFaQYFiBd7iU2YgaR3XPr1W7Pz+q2I2lBkCByTsEeV+Cy7W5S4Q/s3TTV03Jaf2HINnsw9SKvQykKEyATtf/tBSyK+5C3atn06wE5KW6CyHuT19NyTj2ZGngEV3xDXsVyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDijJ4rfLzCpw2g0lAaNccRV95Wk963NyIAgMKVa7F4=;
 b=BuLDBTFzJWayzQQKRSHXtrxIZlT26/dSJJjYtEKENn0D1H+PPD9ZXyW+6JAH2PMqLrgw3TnshJ5mmBqxxu6t4jeVKk/gFJAHAsmv/YdNzORdymwjNQufFha0+GFDO2LQj8xEULXY8Nve3xXX2AJFM5T9NC96aOQ8Ic+neIz5z9A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS3PR01MB6657.jpnprd01.prod.outlook.com (2603:1096:604:10b::10)
 by TYCPR01MB11268.jpnprd01.prod.outlook.com (2603:1096:400:3bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Fri, 1 Aug
 2025 08:48:58 +0000
Received: from OS3PR01MB6657.jpnprd01.prod.outlook.com
 ([fe80::8575:e22a:3c44:76f0]) by OS3PR01MB6657.jpnprd01.prod.outlook.com
 ([fe80::8575:e22a:3c44:76f0%5]) with mapi id 15.20.8989.013; Fri, 1 Aug 2025
 08:48:58 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: tomm.merciai@gmail.com
Cc: linux-renesas-soc@vger.kernel.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: dma: rz-dmac: Document RZ/G3E family of SoCs
Date: Fri,  1 Aug 2025 10:48:22 +0200
Message-ID: <20250801084825.471011-3-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250801084825.471011-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250801084825.471011-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MRXP264CA0009.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:15::21) To OS3PR01MB6657.jpnprd01.prod.outlook.com
 (2603:1096:604:10b::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB6657:EE_|TYCPR01MB11268:EE_
X-MS-Office365-Filtering-Correlation-Id: bb905689-00d4-4ed3-d029-08ddd0d840f7
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?67bdVAARE+m7E60S2fu7CxA89O2oKF7S7T191QJuUxGZVOEjbC+CC6Y1PQm8?=
 =?us-ascii?Q?wJadEtu5CejGka7t5MvGrfF070vkM1kt3RP/1qOuq6o/AsgXf3lddLW9zZK/?=
 =?us-ascii?Q?SA5g9jWh0xC4CFdEg2USF6uZVqjlTQ9Y3jGPE/cwZeNkLPJF48zavvqPEBFd?=
 =?us-ascii?Q?9vwE5UEAEg1CvmCUFQi6N2J+9NXdk+VosE9m5gt7i8iPZOfWN5R6agrbBIG3?=
 =?us-ascii?Q?UB4Q6RptXW3ICrEMX3XDSlp57naxEKR5dRrpRrsCxZuK4G3oxhnk/mZo5Xbd?=
 =?us-ascii?Q?Fl8Dq+nat5qA2c6B+9v4BHfvARKJKklQuUqYjtGJCK/INUzARO55meqjxUGm?=
 =?us-ascii?Q?ewZ54hCmNAC1OSz5t2RWH5810eIORCSbBvyCxKyZMpuJH7/9INSti7FWO8ic?=
 =?us-ascii?Q?tRFSikyF93LkX0lz3c7nqvmRsiaV8pJAbJuvuOJEE6Ri5EqpSxISpj3YkA0a?=
 =?us-ascii?Q?nM9nAT4K5j0C7Ns29cJMpK+cma+8NmwAVlqPYMSAPydhB0szdyTVtEXmlQhy?=
 =?us-ascii?Q?8fgRHOQEHzAfbSd7FxyNJdtncQ2o0esUUkNKORaGY0lZLUUrbfSeF0CnLn9x?=
 =?us-ascii?Q?vCjVUk4wk4e8cYRf9IT9o2VXIw63aBBr0ZGdGt1/wOPvKaiZbUDJr0CKbQWo?=
 =?us-ascii?Q?UVx/6suqtYOTIFojjSTpAsvSYu1UJWg+JJ0PVUmM2uj3UUE2aKIep7HUO8wi?=
 =?us-ascii?Q?6cl7fgof9g1WfT7eHMZP54i1KvXVwuR4L7ECB21OR77/nnc2E/op1N1ZhZ+x?=
 =?us-ascii?Q?m2K30PxaoIrn35CePidJ0APYGq782DbtybhsXzq0ClF+lxM2HLuOb/f72DY5?=
 =?us-ascii?Q?qeFKxQvhmXJlGLOL2sWMkDJUFp33Sw08vTCPHd+T6W8v/dn+OINZWD2i0m6a?=
 =?us-ascii?Q?6mFroUxdlvz91Ms55xcJD/w5k7W0yHzTfj1ikgpEk+nCoH7OfEP44sXcYvUd?=
 =?us-ascii?Q?fFiDo916I5tMPvwX1bozAvZv28xtrTox+MBYNOeHaFBKlkt2QqO1PlnwAYie?=
 =?us-ascii?Q?APbtuZrZtdpxGPLW2pi+JHhdxFkukN/B8BS5N2KM/x0xehsWFdIrQb/lRloS?=
 =?us-ascii?Q?fYfXhcnPxcJSFCp12d4k3+l3MzzLoP11L8ZB4UgM3TkI0ig0qnFEqN3x22FD?=
 =?us-ascii?Q?PcRpagqoYM+kCbJ8ixkfDsi5unSYlM+mDBg1tMUTNX/A2wsDNFeIv/YnOyvj?=
 =?us-ascii?Q?NhCLknYzeOVS5mrki/3A3I+N07rUhEtIxFmEdRX6hWHxd8s3LsxVLipez7fc?=
 =?us-ascii?Q?TiGb8N5jWnSA+Z8y1kg3iikuawpzwz6QR9uVtCfe0Ugn78x9Ky1iNeGQuRXu?=
 =?us-ascii?Q?bVHGP97/tx8Gunq8vBOJoyq0beLQz3J50A3NOiKx3pZsuohjEZvTAXzq7hAm?=
 =?us-ascii?Q?tFZuwREMJ5zfJsztT0/FQZ8ewao6UrrBdwKa+h7yGSlX5iJMYLMtlxo9ZA6v?=
 =?us-ascii?Q?538cXsPS4eioUuV4rpxgGIfSi8j4TWhArzEOzbhecV8ajzs2RzSUJg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6657.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Be3kKpjKjEt5Mm2vB4DK1V0VcXkiLI+3UPUWprU6fPxWpVtu0vvYN3TpfdXN?=
 =?us-ascii?Q?aN4VfC8JbhszxkYad/jvkp0REJk+MnkILL3qb500nQizvfgv9HX/8cu+1aDU?=
 =?us-ascii?Q?MxQnFlK9N+rF/0aeoNUsMSZZ4Fy+Fy/5yJ9JsmyPdS4UaPhrvlfU/w4sVPnl?=
 =?us-ascii?Q?MYnoHCrMo1onMuOmVeWZx59ZUg9PaU1DPHiT+YlZ/TDSRHcGbQaZUnVB0DUF?=
 =?us-ascii?Q?ddLADwyXDER0Z2H5MaudkqkFs6hLlyENb7aDwi1P48CyscQ3HerA/G9DqoyL?=
 =?us-ascii?Q?BjK4fv2XedXxp2Kd6R00VlM1XXZrS/eAb5k5xoeh+1rssYBJsLci81eLxhoE?=
 =?us-ascii?Q?FhPLmB/Jy2mP2W0tCzCnofChZYaaLdXDKsN5P524aPONgjB+lgvWcZ17LITN?=
 =?us-ascii?Q?mv13dbCG+HZwmgGltlYFjHbZgqHu7kidJ0+va1bMSkvUrClmcdDnurR3Dwxs?=
 =?us-ascii?Q?Jnp177uZ3Z87/aFOrspb1WPdjgE7Rt1b35DeJ68tR2x8wVbb6UKoN8Xgc+TN?=
 =?us-ascii?Q?hnD+5Lq0CTwS4DHIIfzLtauoL9SgMj5jXgk5NKdBYW0+u+o+4HqeA0kPaM+N?=
 =?us-ascii?Q?NmNhRH5gYt++L9ggmgzTV+rLHIZ8cYyoYVlgUh3OyKN5G7LQaWQDSllkMQVC?=
 =?us-ascii?Q?z+93XBa8d4UwFa4CppzQngYXsHokurtp2R4oIP7qzKB9z6DFXrBFh/EtJJNq?=
 =?us-ascii?Q?2HF/+q9YJuEbXg7yXLjFCuVmLKU6BJBrk7cPae/YmlRKo+aNEI70IR9NcNwx?=
 =?us-ascii?Q?vt+IXyxTesRUCOBRINcHt7suazKQ6IRtpP6Qs85+MO15hN8VuouOThLTWmSC?=
 =?us-ascii?Q?ARvnnPQb01K64gs2N+ITThf41Ch7MFCue2/4d+Ojk5FycHt7PkVuoQjr/NU6?=
 =?us-ascii?Q?qNktzRqiOQKm6M4MkiKsfWm9Z9NYjZ3+6X1Fqrmw7sAMhwHMf9qfCelp0P21?=
 =?us-ascii?Q?gbViIif4B/44DRi1Qv2/buOrAMrgL0xVCIeidt5kFjfokSH/YUDgqa5nj27D?=
 =?us-ascii?Q?W54enrPUobNr5AXbeB4M0JoLoz+a4X7i2QCcUxreEuxHpptCA4bGtbSRG2vT?=
 =?us-ascii?Q?RRXXMKR4f7Uz1EgwOSqSjSQ992gqwCUmrN6kHz4axZUZazVz0LgnuMMheUBV?=
 =?us-ascii?Q?FlZcGzjrKuh4fGJM/762QVNo55JrjzJG8bNsHQ5C7E61QG19IEc2WWmxpDbP?=
 =?us-ascii?Q?WqAC4Gxx/kv48ckRBKHh8jYeaL2rj01c1fb2zOAI6Adbk81Sp8tU/kpGWPf4?=
 =?us-ascii?Q?uE7yppO9S6pjUhKlpQd84L4VWgbJQMCC/FQwJ0ZJL8MWEAMrrPZM4hKMBRGK?=
 =?us-ascii?Q?J7Ogq8nN0ZNW/WWk4OeeuvfW7xQL+w7QX55NCcLHJ1/fbuFrHnMzsdUC6Ib2?=
 =?us-ascii?Q?+qttMTiWGG2UMmhbltKlKlVsSnYBebpoIdi8cpbtjH6cIUcKB91QNauIUo0G?=
 =?us-ascii?Q?Ha7mnffhRNmWOozykQ1gy3Rzum9RxsdPx/75cKqp+Qtu6t9AHT36oxgOBtz6?=
 =?us-ascii?Q?H02cH5mkDjD7QLKUG0m7wxBPqZ1opOM8UfUTUXF8W3QRuvyV+nnp5C17kgxf?=
 =?us-ascii?Q?Q3KuxRFI/Dr+ULrFQnAR8T0Ngk64K96pzeyHquhFsDZrk6FXxM6G2/Iilt3/?=
 =?us-ascii?Q?t9fv6D5IS51xpRt7dxV1t3E=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb905689-00d4-4ed3-d029-08ddd0d840f7
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6657.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 08:48:58.1914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bvHr3Fu3++vk/2IluApuNN5Vd+Sr5Be+OfSx9+7UzRXTsrgRrJcyMu+hkr2P+daHJPZS/b+ue3Q/EKz4BX09aHCBdWtS2bTVxXHsO67ZYDDvL3Kwlhic7F598X+k8gDj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11268

The DMAC block on the RZ/G3E SoC is identical to the one found on the
RZ/V2H(P) SoC.

No driver changes are required, as `renesas,r9a09g057-dmac` will be used
as a fallback compatible string on the RZ/G3E SoC.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
index 92b12762c472..f891cfcc48c7 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
@@ -21,6 +21,11 @@ properties:
               - renesas,r9a08g045-dmac # RZ/G3S
           - const: renesas,rz-dmac
 
+      - items:
+          - enum:
+              - renesas,r9a09g047-dmac # RZ/G3E
+          - const: renesas,r9a09g057-dmac
+
       - const: renesas,r9a09g057-dmac # RZ/V2H(P)
 
   reg:
-- 
2.43.0



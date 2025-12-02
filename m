Return-Path: <dmaengine+bounces-7474-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C9FC9D5D7
	for <lists+dmaengine@lfdr.de>; Wed, 03 Dec 2025 00:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23D83A87D5
	for <lists+dmaengine@lfdr.de>; Tue,  2 Dec 2025 23:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6788F311C10;
	Tue,  2 Dec 2025 23:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="n3llAUDL"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010008.outbound.protection.outlook.com [52.101.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC1430FF2F;
	Tue,  2 Dec 2025 23:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764719270; cv=fail; b=PAH0PZzpO9k3UJPX3NGQ4QweL8UAfzimkP0aWaK1BXLwt14qflsk/CK5+AoYdg+V2eWG7QdjtG3sSg8GQAzFqiowMlNg549b1IPq5bTArTWLeWQ0U9ob9IgxiYaA6O4NYZTmzr5CR39Tw2mshurdDZCwssedDVPIgH/oUv8piQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764719270; c=relaxed/simple;
	bh=0T0eW+VNdTnweM35nrIAwdoOwkkoUicrjafpJySe/ew=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fvMTU/Xl5FWcVkrNflxkHzfDtnF0JhySx06i9A7lCoskxam/QlMxv7fTAEih5ghQRoz9738n+CSZu5WoXqmWhRs2CifgAhgCwDJAl1uO0fljJgTCkiTSIY8GR/eYXZNZhJ3qCEVTojnHfiJuTl6gX4E1yVNzNFnwB/7rvzXBNx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=n3llAUDL; arc=fail smtp.client-ip=52.101.201.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SkOErkLmEv28MBtzEIEMKmYkcAuu5HnV0saTIS7qNxuJcPNN4CjMSv9OGlOkCSalCjSLVmY3xS7WzBtAgMCHyAS/qfmCBEBSTeVYmcO+GWxH+2laWRPN5ZnxkJ4ox1SzjqpbJSPm4VUfv/4CYCcuq9nuVOJL2GxAQpp8SKF+572B2XiaXXE10fbsoW30SBjwcg8Ag/f4IrljocUzt3Ol2b2fy6hGliEdHki+kP8JGcSvLlAJbIKq2zLuyrL4a+eHOYMlAdPmxZcFQtiKPVKCdl2gnsHgytaWScSGJG5lvLPFb28FtclyHzflPk7XC4/DyyBxPvXEqmkZUwLP1TYiYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bH57AXRPFR9chUzxW3DxsNWQ1S3Ciapd+jUUWnvujA=;
 b=g/+bOphEBTDCpMvwFARjNm28EpHOZ6ZmpRR9M1l2YHjxHM0knVuTB5zcF2cLuBOvbVSNI2LvQoLdbvfyRJT4ez3AYUfcajiqXan3tio2sI5xuqwJWP6eRMnmv9xyYLxdQE7UQ2m2MfTiRYEphdCNXQECYDBzMiOMt9mbxMxhftUz74TX6EBcJ525D+Q5zXqfMSBTGaW/s0tQ0mAhnht7bbZiIkzrWsFx3H4nPIrIZYzmB8N5TkLYyWHy6dziczrHV0OwJvOE4a64cCIJUMoYx28wA9sgKNZP8Z6j/sXG7dfNO3InC2vQi8b8P3ankNXzuUPE2FeqlRgYS1DLvYQ6Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bH57AXRPFR9chUzxW3DxsNWQ1S3Ciapd+jUUWnvujA=;
 b=n3llAUDLkwebLKbmbE8IOVkUTAgX7mdn6qrr0t7HFNSLMe5Uid2++OLwIptPv6ZIXEjTih1gOE427adHuYp2lOePe3W7gym9gchSSD6yIdVeGLMETI/Wym5DgpwbrWdIIKz/miQpq0dv/uAMAA4C0Ljs8q5j5DOOkvEQHsCPKZzcAdtb1wpn7gcPN3kbvXtt8dypBP2X1lg9peBgdvoXA/wVElPpETocHNcmRmSwuzbygjspo+CAiEtkyItd6TSM4V6Eh8cyxmV4oD7NmzLcejk/q6VN13eAfKTrp0r7l9zXACG5NripIm57ItBpS/R4NSfQcseJobMPtxNlT2rTyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS4PR03MB8447.namprd03.prod.outlook.com (2603:10b6:8:322::12)
 by SA2PR03MB5689.namprd03.prod.outlook.com (2603:10b6:806:119::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 23:47:47 +0000
Received: from DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a]) by DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a%2]) with mapi id 15.20.9388.003; Tue, 2 Dec 2025
 23:47:47 +0000
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
Subject: [PATCH v2 1/3] dt-bindings: mtd: cdns,hp-nfc: Add dma-coherent property
Date: Wed,  3 Dec 2025 07:47:33 +0800
Message-ID: <fa3777579d15a803c4330c2a536f0026ae6f9fd1.1764717960.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1764717960.git.khairul.anuar.romli@altera.com>
References: <cover.1764717960.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0122.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::7) To DS4PR03MB8447.namprd03.prod.outlook.com
 (2603:10b6:8:322::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR03MB8447:EE_|SA2PR03MB5689:EE_
X-MS-Office365-Filtering-Correlation-Id: c7e87355-5cd1-4b04-6591-08de31fd323a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?24NQmcxVX3gK1rop13KkNCekFsLQo3vVbypAL6YTH1Ee+03u/GCIh6+XgUTs?=
 =?us-ascii?Q?mgA9rRHseDDf126jj9ERepTKvvZRmq+8fd1+JTTiFyYFmiPjyG509P4hpZIf?=
 =?us-ascii?Q?65KykfAahmr0PX8gMkstKJtNQJIV2izfE6AS0swQwsvzOmN4d0H9wfALeNgL?=
 =?us-ascii?Q?ba9oLh6Zd20i/75qCwyNByEu7vWJloILvvjSQSD2LmyxSJVhcMFrWZk/++IH?=
 =?us-ascii?Q?71DLYwJA/PTLagl3XPLtySOBfqkgfDv4jthAxg+O/CwWDp+lmIY5wNUtJfKA?=
 =?us-ascii?Q?CayGuw7HneC2wR56n8uO4b8jzSaS+Uv12IL31VxwN/FV16NpyIZjUffWrkHw?=
 =?us-ascii?Q?9p4jf1Qml8ywZh6g7rGwtHjV3k0LUp37RkR+DQrr6wzbm3lWUo6MaotUE8lP?=
 =?us-ascii?Q?kJ0EMeMlS0rNVLH65swTCasqdNOsfS6UTeX/GiE3V37m+UCioifsK7Xx+MKf?=
 =?us-ascii?Q?YQW0ZbUEvCQLPW3U5VjVNZLwpg69fGd1d8DrJk9gYGO/T6G6mmJGCo0k5aku?=
 =?us-ascii?Q?Atm08aQpZVkCDQCHzBFcjXiUpsoQDDi8o9HxX38hLtzO8mBDjTUPyiLvY8L6?=
 =?us-ascii?Q?vcBR3mDuDxpT8enqzbk+1VmIe6nhaY8/2E+Pwr0vO6PS5viR8ju0lyxBeLht?=
 =?us-ascii?Q?DUFVRpGK6CaBGNWEVzPbzPf7/kL9lXbztFLrJsEQGUiD1at7n586s4KIo+Vo?=
 =?us-ascii?Q?aqz6WAVkay6U0xFCQgT8SVcjQL1kOwbp9+0mTfuoCUPvId7hsKuIPSxH7xtm?=
 =?us-ascii?Q?m6qOx8Hc2+eeiECDaR/CBVIWcN9FBz1QKaCnQkXiq4Ygr+fov7RPFtGP/zFh?=
 =?us-ascii?Q?aGsidin5LS+YDi82kclZ/L258NtAMTFVeDweyBg3DuGe/Qe0Nk6XS8USFSiO?=
 =?us-ascii?Q?RmOFi1TDXY5pZAwH0VMfEh2U6Ye+PyCcfv6dS0+Qom2Evg+CdlGCWHKpbMwi?=
 =?us-ascii?Q?bd6AYKWlttHAFNGFohvs/Kl8ZIJpR4lrFeFxTNDq2vZYve28n/cK2Ssc5DTu?=
 =?us-ascii?Q?OGBEBFjPPgGYSLdZH5EQpNtxE4VmnsVptk6AosB+LKbX5rIZkEL5ha/0tplO?=
 =?us-ascii?Q?w7HPsd/oF2pNHNEiA/zYk9qgIUPRHkM6JbvZYpWOX3igCNZMvwhWTYCTKmMS?=
 =?us-ascii?Q?U96M4k4yhELCFnGhMI6xKrgs6AO0Pwr0mkkFzErWLOiD8z+l61GpPjqadFPR?=
 =?us-ascii?Q?11CuUmBh63ZLAJReOEOz2EZX3Bi85nTfrgK8suGLzMc65Z4uKF5kcTIOKNVz?=
 =?us-ascii?Q?tFsIeLNURFw3b2x7WEes4NW3ppcgz/0YQizIk3QT4YGtZL398t9Q1Dhyb666?=
 =?us-ascii?Q?NARZ7f04alwbJJNXA/FE/JRmSwTDJtfJLRCn0Nin7tTGxm1mv14/77uZqRly?=
 =?us-ascii?Q?rPD7Lu0Um0BTqBkaeQjS5Emp6Ea/5s44ZCsjofZ4xupr/w+/QJ8960VrAJkB?=
 =?us-ascii?Q?gUSvRYH3n97+mXSlfs+gLq+ZwsgOwQ32WH+7lF/ZLdVFfgUhA3AZnXwZxOvr?=
 =?us-ascii?Q?QShTRD9/mK1vBkQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR03MB8447.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?btWfaemQpUegIOGIWguOhO2f+NYKl6UmJC499Q4/vmcyqUIfUDgDywjciJhk?=
 =?us-ascii?Q?NB5nX/HgBKE19QgzgwEN0Zh0tDV+sfbcp/M79ak6Lo0xQh2yVC5bL3P+c09x?=
 =?us-ascii?Q?tk5F9Myho+9gNHS6dXXCjq4wGCbKLInx3/0EawhsnvCjfnSayTkNOuSE18ZI?=
 =?us-ascii?Q?6/kts7VHI7ieurCWqFAvKOZUc6AXvkcLsn5RpEQ7XyZ6ZQnMT2Gx+wDZT/I+?=
 =?us-ascii?Q?RcNHTT6wjWw6AjycPRtjIKkc4/cd/E7FbzrLrzmcq8WleafJ8mLQEe/cwzI7?=
 =?us-ascii?Q?8hFc+6Zj7vYuahfFxqV8F/5c5OSQouQ54cmAzAQJmBSF85fgFl0L6tLTOw9w?=
 =?us-ascii?Q?au8QyDzFoGl9TJ+ETnpAxAqUG91ExSlTs8tRZrWmP6vShL6b1Bz8b1nWpS+0?=
 =?us-ascii?Q?jKsRevUKMGbFPtgrzT/o3tGgra9KtmL4L1gRWs5iFxg8+QvERqjPQYdx4/n0?=
 =?us-ascii?Q?onos5Oj3njlJrifnBUT3pD7bTQeVnMfB/qXyObS0DhtVCLhcUfQ68TWn7iYc?=
 =?us-ascii?Q?SllJdJoSpqX5zWKoib3E7VXBN6/V0HLRPzjsX/Zy+orf1TmJyZ5GPyNgI+0p?=
 =?us-ascii?Q?eG2g6bIG9eD5P0RrEl67NCPcHw+ifYZPHKTlY/c6l5wYL42B3yaU0x39nVRE?=
 =?us-ascii?Q?qmQPCm8yE0IuLrImElO7K6+WBBsGv84Uj8qMvAOiL8P0/GQoxtc35fyB6Pj0?=
 =?us-ascii?Q?zDkoYQKYN5ae4PL+s8VvRyJpgoQRPkMdl42gaqz2SUMca1LWC+92lotcHaOu?=
 =?us-ascii?Q?AlwurOTB3IGSmhXphlHpDP28a97oTvstEhDHXVuqNQByxX2Wx6gXygyMfX+V?=
 =?us-ascii?Q?16H3bP1Vt6oxmwJ83rHt+GAlvSWEoGKrOkWu6LptqyJ0bWvzBXcs1MkMvlA3?=
 =?us-ascii?Q?DSOXemRX5bZa6/pqeNhZ4V4Ol559SoOnwFs0WJHykdtUvmHrevsRghTyQEzj?=
 =?us-ascii?Q?6I/hqLn/AFr2lXo81dJyba88UkWKf7jn+IAnrOPa9wqYwYt1Z0gRttWZSeBb?=
 =?us-ascii?Q?PqSae12/fjmnZ7sw20SiQPqZqFbC/Uiyz4o6HC/xXHX9DyXDeJXtTvuSFzge?=
 =?us-ascii?Q?pHYAoalvLqnXg94cg9pvj5ez6MZkQMi+d+v7OYBOfM7RIEzXesMrMyN3Oen3?=
 =?us-ascii?Q?RoHCWf89BIJCdPJmNxrgkRoNgmMEmA29xuKAjtBnW5nliNmJO6d2HBaxpgzv?=
 =?us-ascii?Q?HVznxWMz21oq2VH2t4rYZHuMiD3JfR3vUbI+6DcNfMfedGR6zPb4GVL8sGyA?=
 =?us-ascii?Q?8I0QX2CPwwwMC82pdI78shMgzU5kiyzVbGa9vgd7GTZ6TQ8VCoG66r7+XcT8?=
 =?us-ascii?Q?Ejjhm0a9VT6yIdkGnf0anOerzT/uU5KTYyWu95xfpTrtAKWb4zsYUCzk5fip?=
 =?us-ascii?Q?o/bBFvA43wb3BB6IjfTQD6zdCYzH6lTWvcxadtklBvCVvJJzzEorhtkqd9Ra?=
 =?us-ascii?Q?lGrvFu+fu8sAMl3FVSvDMbwYVHWu0dN/UG8uxXBbG+MTIP++CrVurnO3ZNIc?=
 =?us-ascii?Q?rxz1gZIXBBW///0TnrRFiMUbWGKC5mOZT3EtsARsrF2lQpIhYl6AZ84xTN2r?=
 =?us-ascii?Q?vgJxRllYtaAVvEI1K1DrAYltkPGZG5kdSY0OO93JTNOJMn8Cs6ZTNPvDjmk4?=
 =?us-ascii?Q?2g=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e87355-5cd1-4b04-6591-08de31fd323a
X-MS-Exchange-CrossTenant-AuthSource: DS4PR03MB8447.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 23:47:47.5120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +hEcHIHl/KJvivJkStKtIbHzSb71/tT5kJB5OgCLioCuS223p3iuDnzDCMjb4Atmka8J858p3lO68zpTUULzfygqymJwuoNtlDQvE9wcYj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5689

The Cadence HP NAND Flash Controller on supports DMA transactions through
a coherent interconnect. In previous generations SoC (Stratix10 and Agilex)
the interconnect was non-coherent, hence there is no need for dma-coherent
property to be presence. In Agilex 5, the architecture has changed. It
introduced a coherent interconnect that supports cache-coherent DMA.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
Changes in v2:
	- Rephrase commit message to describe why the property is needed now
	  and was not needed previously.
	- Remove redundant statement.
---
 Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml b/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml
index 73dc69cee4d8..367257a227b1 100644
--- a/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml
+++ b/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml
@@ -40,6 +40,8 @@ properties:
   dmas:
     maxItems: 1
 
+  dma-coherent: true
+
   iommus:
     maxItems: 1
 
-- 
2.43.7



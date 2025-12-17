Return-Path: <dmaengine+bounces-7770-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CC382CC87BB
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 16:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56FB530928E4
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 15:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F711340A4A;
	Wed, 17 Dec 2025 15:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="CVnzTFwA"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011057.outbound.protection.outlook.com [52.101.125.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8C433FE27;
	Wed, 17 Dec 2025 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765984641; cv=fail; b=ja1TZdj5dwQ7iPFbEi/u6z+jkPNy/CqPSo8dsfgeYszOuQM28LOdsgUyHunC/qV1JgLsHichsU5whwUT/6LF+ElKNLL4FVenNoDUzbsQwY+uumi5KPBMNskc3xoDdLoN9RMDJ7HfSkkTJgqp7OAQsKjLNgnMYXXiQKHrQ1OrMHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765984641; c=relaxed/simple;
	bh=QSUHcsskYTBKX0EzCQA3OX8U+fK2bACW3TRIRm+525o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tzjq50W3E7c345wI8ouYbzx06rE2eBcVeWQEN0Jbdpw+r3MPW4hF2jlr0BbC66oumtoE2uGRA0HV769M0Qy+FlBdDSYMad4HneSwhtA6BM1QtZSbPXwtkhuWuAJUKUM6BPPQTV8v2XTQibP+NAO9/fP8Fug3wZSmXWqUn1SsTQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=CVnzTFwA; arc=fail smtp.client-ip=52.101.125.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DlhLqXp3tAC3e0X+5p20e+uRxpCC/3veNiPBkGhPgKEW9/Q/r+M78/M22xPZoQttyPGGWv0Nddoj3SlRm8mGZH1C83I1BILqMuGdO5xHZLmMS2xGE0PfWi4xOH2XoFb/taE3Gg6FMlQshVd6iYUUmTqLPk8sCf51lM9pWJKwMvKlS1bH7b1OOQPvwiW3HE6ZM5WjG+WXWqWhzSJJRz2OdcxKjUx4H8uPy3MvyWK4YDS/rjtkbTg3F3zM5DItWXHYzgkVXTsZp9cDmeQg0r5WJvHuKYRw6O0P1cGnVjeaqH6oKo/LvIiJvxARmMZzUsn29c9BD655VPZxMNLivMcuYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyUe2vS/QRyNbmh36k1mjp3mvMKi5eTaqFoHSB6xHnw=;
 b=M7GI3SpySN+F544ToZtJzYY/RRPZgKYpYCW09nn5pDGp0yECpR3GkWkkTltc0IEyuirm0DYgC4DIhheJs3MQ2gnBr4lltx17ZTOVHbn0iISon7Exurrf9EskYStTE5fSc6/njKUJnkPreXueZIpD/Gvqx3v+HXa/Y/I8fLfumxIRmTbjZcgNjpukBnAsbBu7RMjU+5dl9nQajy+Q0pZKuuFAn8OWcH0YmfKU6x6cU3EtRHsGQbRNozyaNpewGqPqqauStUpJD6JHiJkxq78XUCdOaHHjcmATOEDSKvAK1iKmLOuDEXdaYSr2VLpk9A1AJ6UCN5PGR+4XdQq+K3WxeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyUe2vS/QRyNbmh36k1mjp3mvMKi5eTaqFoHSB6xHnw=;
 b=CVnzTFwAob/ErXCWlM07UGVAxEwjiEOl849GR/VF3vvxjePuc7ctnRIVuv6pRIJwLvMo04C33XnwB982BraC1wfCY7NXhBFg9bVKaHMFUBN7RvDnEGrJHvbpRcdTWokAHhmNFKWNaUJMd1jZyBNIQNIJb0lQShcR7apRv4LN5Lw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYCP286MB3469.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3ab::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:17:12 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:17:12 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com,
	dave.jiang@intel.com,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	jdmason@kudzu.us,
	allenbh@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com,
	logang@deltatee.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	utkarsh02t@gmail.com,
	jbrunet@baylibre.com,
	dlemoal@kernel.org,
	arnd@arndb.de,
	elfring@users.sourceforge.net,
	den@valinux.co.jp
Subject: [RFC PATCH v3 35/35] Documentation: driver-api: ntb: Document remote eDMA transport backend
Date: Thu, 18 Dec 2025 00:16:09 +0900
Message-ID: <20251217151609.3162665-36-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251217151609.3162665-1-den@valinux.co.jp>
References: <20251217151609.3162665-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0094.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::18) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYCP286MB3469:EE_
X-MS-Office365-Filtering-Correlation-Id: 2833e91d-766d-47c4-e1ac-08de3d7f4a58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dpvn3XzDXRiU1fzE0ox1CxVrmNbETEHxKSxRgluaUn2LS2IVG74iQ6rzvxlV?=
 =?us-ascii?Q?uokneXdryVNJSHGPribYEFxowt2jjXIZCScBc+z+grTXKEDo9wqohnhR1jX5?=
 =?us-ascii?Q?JxrqzgsP3ufoOqNImgDzXoaFj0AzKVK+8xiYZ5B7uZ05AmIoWqAt2D2IIN9q?=
 =?us-ascii?Q?rNNambO0QBZLO/I84YsfmyPqqQPXQbyQwt9Cl0qcEuM59pt5i7ock6tihDKW?=
 =?us-ascii?Q?GSd67UvcYOpaRP6rLBaYUFykEPrd+jiH4bcpdxrqn9lqmH5DFRfAx/BNtvKR?=
 =?us-ascii?Q?/KLjGjbuCVnWDUQkBa9fb0hQ6c4lHlay5Psd05303OPGOgzIBWf9JOF5caCm?=
 =?us-ascii?Q?iZcesBF5nQCQ2hAad3dc6AaIQ3n484DVT/KaoRIEjtKDPqyoAeOhvQ2SZ/ll?=
 =?us-ascii?Q?5phzsEnqIrHkqpNXRkU8nRo4YcT3I1XqC9FAdXGdZAERCt84fSgKv87++6gr?=
 =?us-ascii?Q?TJXW2b4mICk+sJR0bnK2mewZW8fN+vRfG8Qs268Tg0sxWSAYuH0NcK75r2D1?=
 =?us-ascii?Q?WMllP5g/Zxmg4ZqnCK77DXeEjo13bplAdP7JNwtgfJsjrNzSdauFZe8vb0Fe?=
 =?us-ascii?Q?4BqyBTOXV624CHwNOXdObuLSBdIiTUFJjuPqLjfk5ir21UlTW0/bMYoJSVt4?=
 =?us-ascii?Q?n42SPZULO88yzR8y1kTL1Vef3OP5C+paIk1J0j61eZjGGs4FKmY4FjyVH/ya?=
 =?us-ascii?Q?CRmr7tvKsoxJrZkectFpj9sfy7ai8tZEzWUirsEcIvYlKcScjix7Ef2p+esW?=
 =?us-ascii?Q?DlOhNOn1QvTeRJUktsYgZWcoPalQgg/VeePPWqCW1STXtaD/q18ef25uPKP3?=
 =?us-ascii?Q?lw72Q+ZH1h5ZvL7t68AzflM20gNxUNW3NYyp4PLaJ6dlYEIlp75/yzfZmaGa?=
 =?us-ascii?Q?u6GY1LbIqlE2TbgChMC4jdpwimxVyCW2jk8bMcXW4+DaMIMdv2sSMZBXUXp/?=
 =?us-ascii?Q?aL/4QKQtqveDLabb1vNaei3dZSYzWbcp1qzNL/uuBIhK+Tps8Dy+UOglsNjd?=
 =?us-ascii?Q?0NCRmAGS+sHDdmcKs9nTMLN6ZQriFdeQVhzHK9t8NxwJYe+qZNYsQ8gUNHt6?=
 =?us-ascii?Q?dsR91J3EeIPC1MlFhXGv6VZHoeMHWeh7Pke5d1eCMYSk+mDgA+Ncy6rjldpy?=
 =?us-ascii?Q?P0JVGnN/je/cd9ZV/vkk38wmNtvALzwL81PTcwG3aRJdAUShdPj3cHzK3j4r?=
 =?us-ascii?Q?aqbp38f2xrT1Y9mVbteAnAWRUoSWbPDN4AydRXHfJrfxJe/1Rt/3GwxN98G4?=
 =?us-ascii?Q?iGSx+Pv+tuNC2dMuFz6opoGLhxheL07neH8CvKtkJi1lQAoU8WRJ59jypQbP?=
 =?us-ascii?Q?vW/P2RCWuBxQ4UWOsKzV7qaXiZW+o62dOVLf+lW4Y1cMfw4wL6p5JCeVQSeX?=
 =?us-ascii?Q?dG+DhcM6iTUmV/iS1/IbyMl1PLpvfQa/T7ZxZRelHy0t1yAhY1JaDUuNWhUL?=
 =?us-ascii?Q?WxS5J2EGxlPR5LGArc1g5AbBEPcqszOl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wkce+hLEHGlPbePIJdf6XJreNRzGXE2PFMvdIPFvH/5eJR9fcl8/g6jDw/mt?=
 =?us-ascii?Q?IOCtoyT6WRrpXL4deVzv1H8oMEamb4BQJZfziyU5p4HBV/3WfvJcyYhWvgtH?=
 =?us-ascii?Q?sBgB3/t+axC5CVGigCaArFpYB8JBVIFfaPSSVMOvhC9flt0FDTKRmmefHZya?=
 =?us-ascii?Q?zQrpKt4a+BGy1fUxlCwgNXtVHXD3uiLLHh/AK3H77DKogmGVEzvA4KbCc3tw?=
 =?us-ascii?Q?Wgz2c45L15ARxL6ABP566fFa3mg2hV/q/MKD/iaDrGUxLUqceDEg2tOQlkiC?=
 =?us-ascii?Q?DeAQlHKwnlWCuKYjQ/O4xQG1YbK13eW9dnamncMMm7o9Jrs0RW7lF2c1/taE?=
 =?us-ascii?Q?t+Upen8Xvmuw9w0ZuWKZXNEgyojuhUJhIbLbeuDo6tEcDzZvJvF6bry5b1Ui?=
 =?us-ascii?Q?GBkMFicUjODMTOW3J1Z8pwV4PbIjrJE12Mm+9F1MxC4qzMm4HygVozkXJ7VI?=
 =?us-ascii?Q?8O/M+J8SM2hsLKmRDXPofR0vYtwW8sM2bQtfxemTHQd2hyUBEc7FMfmULZq6?=
 =?us-ascii?Q?FgOdVFFKiAFIgBrZYSTI6wWIbLWy+isTkJMgCdZn0YGILoFABddBPszcW8Rk?=
 =?us-ascii?Q?CK6Qziokw2waUcdTuXrYoeFo24RNtYJEri12RZ+Zm+oOuzZBPpW/YzKcyVHn?=
 =?us-ascii?Q?pcNsnumLLJ1UPeI6r2QXS3cNognb+Hmc8uf37w686kYLHZ9bBTvHIYn2Nfm/?=
 =?us-ascii?Q?eKsmm7rNRqWvGOnv7b9p2aLG/lG7PZp3Lvu+pqHO2coIbPn2aNWRi+apkA3w?=
 =?us-ascii?Q?Lxar8w8aMOQcf9z8MRBWw2j2R4qrkoShHJneZfFx6y4AIpWcQQPMg1NY10cW?=
 =?us-ascii?Q?+HaW9Lnvg8feH3M3d7BRPC4BCq3fDNph7UMY8U7T6rc+3xhGK7B0ed4dCQUc?=
 =?us-ascii?Q?nHJdX69FqFLUlBiU13aZ7TKYF68C+UxiaWhA+1BVF6cKJWYcCQhdKz1Mrs7C?=
 =?us-ascii?Q?Z4YBd3S56cIkyLIF3UC5rhBYU+/w1X88LOG+C6LeVrsN6eJ+s1PaGgaR6dK9?=
 =?us-ascii?Q?1Pa9z9eNBdRn99miV6M4xN6fXMqUzw/9qFDe5W+kHGUrIopNYdx3TMwXXgxY?=
 =?us-ascii?Q?B8Lw5/fgyHBtVBBdkmtZrGxh8JvXDCm8VJHDBqV+j8p1KboVlSvEcNnTfXVP?=
 =?us-ascii?Q?2a+PxF51FKTKDRv4uwASD9XNa13ti4yL+0ZxEAZazubGVdzsQ2DwjxgXQHWr?=
 =?us-ascii?Q?f8nlDgJZeNheqQYTiOqgcmoY43RHfsBq9vTnCN691XcvSIIqs/4o0dkyEucn?=
 =?us-ascii?Q?bv1LpOQ4yfROeWHoZsb0lz+TDKW59jB8e1dLR08hpDY4mhhtHHi2M7RloctR?=
 =?us-ascii?Q?DmXnTJW0pUQmMq8zqsTe1wEjCs2BO9ghMg4VTopPMmbNRtVKwTyRFRPqw6c2?=
 =?us-ascii?Q?sXczDrUjtkpnbfadjEgrVWYuMEc6fB0Eey5gTq9LDHCuglRaaQzCEo1vYfkT?=
 =?us-ascii?Q?vF/C3+gYGO0r1znO7oAMppoO+w3UAhrx6ZjPYoKeU/TZCnDdmzRZ3btd8hwd?=
 =?us-ascii?Q?DCl+YXI5dk7ShbT6gh0vYOfWObDTUPlrnY+ktArL+Ye5kGsV3hDYkJSMMCim?=
 =?us-ascii?Q?eTAGQUphyetqroUabUnKAK8BJvoVyeSOtsMP/cx0Lza8o3joWyhXpEf3srTF?=
 =?us-ascii?Q?l6NdzpGgEa1tavAmqM/glHY=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2833e91d-766d-47c4-e1ac-08de3d7f4a58
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:16:45.1237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: taR9tcpx4UPf3xwSGHmAimSDJ5/Obw+n0/S9vmtB5wG0vnVZ/DkOUYXqCK/1SXFvk4e9Fy4TDxwbXhsSCyZWWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3469

Add a description of the ntb_transport backend architecture and the new
remote eDMA backed mode introduced by CONFIG_NTB_TRANSPORT_EDMA and the
use_remote_edma module parameter.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 Documentation/driver-api/ntb.rst | 58 ++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/Documentation/driver-api/ntb.rst b/Documentation/driver-api/ntb.rst
index a49c41383779..eb7b889d17c4 100644
--- a/Documentation/driver-api/ntb.rst
+++ b/Documentation/driver-api/ntb.rst
@@ -132,6 +132,64 @@ Transport queue pair.  Network data is copied between socket buffers and the
 Transport queue pair buffer.  The Transport client may be used for other things
 besides Netdev, however no other applications have yet been written.
 
+Transport backends
+~~~~~~~~~~~~~~~~~~
+
+The ``ntb_transport`` core driver implements a generic "queue pair"
+abstraction on top of the memory windows exported by the NTB hardware. Each
+queue pair has a TX and an RX ring and is used by client drivers such as
+``ntb_netdev`` to exchange variable sized payloads with the peer.
+
+There are currently two ways for ``ntb_transport`` to move payload data
+between the local system memory and the peer:
+
+* The default backend copies data between the caller buffers and the TX/RX
+  rings in the memory windows using ``memcpy()`` on the local CPU or, when
+  the ``use_dma`` module parameter is set, a local DMA engine via the
+  standard dmaengine ``DMA_MEMCPY`` interface.
+
+* When ``CONFIG_NTB_TRANSPORT_EDMA`` is enabled in the kernel configuration
+  and the ``use_remote_edma`` module parameter is set at run time, a second
+  backend uses a DesignWare eDMA engine that resides on the endpoint side
+  of the NTB. In this mode the endpoint driver exposes a dedicated peer
+  memory window that contains the eDMA register block together with a small
+  control structure and per-channel linked-list rings only for read
+  channels. The host ioremaps this window and configures a dmaengine
+  device. The endpoint uses its local eDMA write channels for its TX
+  transfer, while the host side uses the remote eDMA read channels for its
+  TX transfer.
+
+The ``ntb_transport`` core routes queue pair operations (enqueue,
+completion polling, link bring-up/teardown etc.) through a small
+backend-ops structure so that both implementations can coexist in the same
+module without affecting the public queue pair API used by clients. From a
+client driver's point of view (for example ``ntb_netdev``) the queue pair
+interface is the same regardless of which backend is active.
+
+When ``use_remote_edma`` is not enabled, ``ntb_transport`` behaves as in
+previous kernels before the optional ``use_remote_edma`` parameter was
+introduced, and continues to use the shared-memory backend. Existing
+configurations that do not select the eDMA backend therefore see no
+behavioural change.
+
+In the remote eDMA mode host-to-endpoint notifications are delivered via a
+dedicated DMA read channel located at the endpoint. In both the default
+backend mode and the remote eDMA mode, endpoint-to-host notifications are
+backed by native MSI support on DW EPC, even when ``use_msi=0``.  Because
+of this, the ``use_msi`` module parameter has no effect when
+``use_remote_edma=1`` on the host.
+
+At a high level, enabling the remote eDMA transport backend requires:
+
+* building the kernel with ``CONFIG_NTB_TRANSPORT`` and
+  ``CONFIG_NTB_TRANSPORT_EDMA`` enabled,
+* configuring the NTB endpoint so that it exposes a memory window containing
+  the eDMA register block, descriptor rings and control structure expected by
+  the helper driver, and
+* loading ``ntb_transport`` on the host with ``use_remote_edma=1`` so that
+  the eDMA-backed backend is selected instead of the default shared-memory
+  backend.
+
 NTB Ping Pong Test Client (ntb\_pingpong)
 -----------------------------------------
 
-- 
2.51.0



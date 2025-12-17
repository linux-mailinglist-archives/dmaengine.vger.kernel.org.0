Return-Path: <dmaengine+bounces-7763-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC45CC86B0
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 16:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75239300F9F4
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 15:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067DE34A3CE;
	Wed, 17 Dec 2025 15:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="pyIwc27d"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011052.outbound.protection.outlook.com [40.107.74.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E56346A11;
	Wed, 17 Dec 2025 15:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765984594; cv=fail; b=KamF04VrYDP26USh1nvTIBr/foOszqTo+iPe+GuNs9dibwxuodJiJQlhTIf1qfHfI1hdsvWxpHPZxXUTgdWc31QWjoapuP+i/DbmYF7ZMrnQxBL60djNBwxbATahHn2idTFiFKEzbZ9dd3elbaT/Ocg9hpKuG0byClCioooEfDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765984594; c=relaxed/simple;
	bh=QulA/l4jlXLSCdzEL01TZUBJhPE+Uy0xusRCEA2UqxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SQoCtBKu+n6GzGf9i6tTuDY2Tfu0kStlnkRwCUxD/V6FaoH82l/PpbKHppJxpfNabbLTwgf2QPHqj69TIDBAw9vw+EzMJ4AcVY4kHNI20UPjVbu15H2bSIbS33upQeAAhZBnRfEszlzyuyroPEwM3Y/6QmC/GD9QuGbMzIlnAL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=pyIwc27d; arc=fail smtp.client-ip=40.107.74.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLFbT9UAOj/XFFPWhR4e+9N7jorEAWRXMsONRrXC9Irmr9BipujG2oi9HvWRaD8yjfb3GbMGd3WjuOhYcNUoF0ido5PgkTWtaZUgSfIEto53hUKaT39aizVl1FHIE6e5rAIaT3+PRWjGhx7EKs3RwJCsWJaNvwLqmu2H+QH2sGKbRtRESXefYS2JPQQY6ZaPU0GHTguXoF65G5EuSDDODHqAywMyOH6K/sAOayb3AvJRLvzrq1PY6gZ0AFGPGhHVr8G50Cla7XhIyYE/NdF6jHqvXQoarnj9zHmw3Zn70t9g1as6/34vxyMapnFKWQXupJ+tsc1ItsebWcsUZY9LfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WhYXTzIUkx70sdTDrWwodMO1dxR+UYO3uw1/O8oDCQ4=;
 b=WqjGm6HzCk9BmVmZllmi2IwO5g/bqvH3wdWue9kWnnfpQNOo62Vyy+LvGlXEBwrDtske2VNqYFuYFg68GqDwQJe58z0pF8oN11fiVgEwWwwaHXWV0ARi5K7eUivJJpWhbaAZWja/WL51W0TmHzv2G7+OPg6ELDsKilX5m0AG5KBY0noaYLvhFIjt7RV1fsY1LwuBt2biSeVPP/kbL4l7xEskMTCeJCJXHPi5pvEJKnh2uPP9zqcr81+Zd06kLgCxtR/jyKXjRGpRoKuChugUTfDHd7YlbXTtRZS/YyYVbYyBH7yM5Pi9OnutYThSV103KSHxfByKzuDrkZSAJPS4uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhYXTzIUkx70sdTDrWwodMO1dxR+UYO3uw1/O8oDCQ4=;
 b=pyIwc27df7uFkxg3oHyH0NnJAVivanX/R1UQsUKEfB0x1I300kYLbN3FlqZ7Z37wK5qcQ8sEFdqKHDNNQL2cZdkmdvDmk4YzlT8Snx3BflIeB37womuyHuJVOBmPNxOTbiRlG1DRSffXXWl6wg7Hf150FGbLrEAAmYhqr2wCTAI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB4633.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:16:23 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:16:23 +0000
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
Subject: [RFC PATCH v3 11/35] NTB: ntb_transport: Move TX memory window setup into setup_qp_mw()
Date: Thu, 18 Dec 2025 00:15:45 +0900
Message-ID: <20251217151609.3162665-12-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251217151609.3162665-1-den@valinux.co.jp>
References: <20251217151609.3162665-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0031.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::18) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB4633:EE_
X-MS-Office365-Filtering-Correlation-Id: 25dcbf3b-eaa1-41bc-8016-08de3d7f3d28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oSF/SwuCPGrzBz+I8Mfnt9jH4AQi+w+HVgM9xAYk/Bdc02+YSSXld3p7zzq/?=
 =?us-ascii?Q?nnRRy7av4vLnPudY6cJTxGQPL6lANMU7n8FJewnIY2SDOB3/KA23Mu/Ig/hh?=
 =?us-ascii?Q?WyoD6/qabZikWvT8g9Z9vDhJoVM40stozX/MpiNKm15Lwpb/9ZJsDCytcFf7?=
 =?us-ascii?Q?M8TBVMjzqPFVh48+dGrgEeR/y0vPBLjSe4V9bDPjlFkbobbHMCON3HXeAR+k?=
 =?us-ascii?Q?iKVZ/QjrdAcUATwYTTM7n/OcwC3yLTQWQmK6MWfpRAvEVi6PQqwBa/VElUqY?=
 =?us-ascii?Q?oyf+Yjdsx/G4sQCa8Fq21qOxtNV/gbRxHJBa+7NUt2rdzB/Ik/O53xJ2FKwV?=
 =?us-ascii?Q?RDGZ6cmR3jhMYFPHbuCKzz4jjFuqS3IoEAxUQSHlc38nswMK618MM/ewsu1f?=
 =?us-ascii?Q?DvaE/+xlLQqr1KQQkbChSg7Uv4CAG/uHVWS8pJXszQc2+LqqMkwVu/A/EavH?=
 =?us-ascii?Q?fkVkJLpFA2ND4mXWRKDYlnYyidSTbaD9whLfSn3IYXzBgmZXtbQx0lTJCkpX?=
 =?us-ascii?Q?+5Ji8glIp+Is/7JAfPDijQDKv75nLBKNjSRnf/jF6ebsnVUiBasI2JBXS6gJ?=
 =?us-ascii?Q?FWzMATClKgk/Rvy1PLGssxXtwVKIhOB8FOq+LlgIusNqdJ6yD4/SwjyvdcS6?=
 =?us-ascii?Q?wIFMVxkbOv4ml5SxQ7cK/TC39/im4oLmnoeuTT3i3kSRK/R20Og1HFrl6iE2?=
 =?us-ascii?Q?bmemUry5hPobDkz1aGyoEttRXIdm9DLXU7ejlO5fla+79Wp0Fy8IeYehowrC?=
 =?us-ascii?Q?1XIN0aY+IvGg2sz5w+qsWzugFYBazfH1CYmMfaTOvQWLosYv4x7WcKnWCVNy?=
 =?us-ascii?Q?wkKWPHwhEp9iJdnYw8i+fgtKHFJoWB0mIVTgd/RY1YJgqeyJc7+aQ3GBCugV?=
 =?us-ascii?Q?aRUZj74k8nzKu+/zXZeE53SKNG+GwJRFN+kA9pqusgBzcYSxYEYMMxAXnTGi?=
 =?us-ascii?Q?FvBiQmrc9YgwAE8eE6n54XdkNW54FQNMjrPDaE5tXfVFdpPdD8kfUsTvEk8M?=
 =?us-ascii?Q?oNESfz+EQJMe9isWE03bj8fhXiwbtUCQv9ZgJGqOYmDrPvOlBFDOCd+vGQpV?=
 =?us-ascii?Q?psPIwqvkaK/DYVxCB/IuaFsXNED6j90k7U5yYtFCMklH7T1drdrwuBdMfttb?=
 =?us-ascii?Q?Y5aFlJ4VGWEValv/0ufM9np/pb8Ak17j1PY46lKajCcBWrSLjjDAoPIkNiuI?=
 =?us-ascii?Q?ehgf98JAnIYcIraGdxK5CFutU/Ghbobg2q2cgyTkpxpwyafYxpklVs8qTag/?=
 =?us-ascii?Q?L1zm6IfX50jFH0e66vIYvbOsmdEjKZrQQ+2MuDRDSSYb6oO4GA6CyGMpT3g4?=
 =?us-ascii?Q?6wp/CkeRLJ5lBvNw9QabR7Iaic+WcY572pxHmN17ihRVB0pa8wHlk6YHMWg0?=
 =?us-ascii?Q?GNoyjn8iBUy6razaVNvOQH9l1uOBZv49O+QbCa2PsUrXnhvCY2KfpiMVHQdS?=
 =?us-ascii?Q?C5C3hInyWjw/b5QcaOzuMEG7NKrg8mpB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CaGtZsmqJ+UxxL1crOoR9iwNQXnYX9ue9N2JDO2Rz4/f4EomK/kJVzZ2AqTn?=
 =?us-ascii?Q?5T21t1c2n7EjgI5KVnic9PEr6c2lgxWux0bVSQweBgTVhcw5TlfwrIGNynv/?=
 =?us-ascii?Q?abJ65HUrxsMCtuEsw8bcsaCWG/mCxp/ZT4MYZ4ixUI9bhxuYg4PEkhX+22OO?=
 =?us-ascii?Q?ZsF0jvTgArYlf4hJ5sY32k9WNzFFgF0bybK7yIuKxra6plOt8noeC2ri2u4Q?=
 =?us-ascii?Q?Y/3+BFP0T45CvVAthC4lmFfkUDZGIvuMcQVSPmKGABN47Qvuvpn4bFfmuSOP?=
 =?us-ascii?Q?tKuAAJtBuqLGA7/lgOdX5bmZIwnMw9rAR1ZUBa3tdTsSkPToKgYIMcFHRQrC?=
 =?us-ascii?Q?JDTno/VuY9Vc4VH3ebdtuyxp3GQ8TOYXC2nPWzztjaPULhk8Tl8g59wpnhnt?=
 =?us-ascii?Q?CoZ06xzLewbtrqaoWTuJRelHLJlK/ZyT3882lyz3hv60hdVRElG0qkrWOLze?=
 =?us-ascii?Q?ucpyo1D0y9FvcPafDn5tFF2eGdlvcNCi8ULweUNk2L6WEJipnksTihr/n3tc?=
 =?us-ascii?Q?RbBfNRFHkV3iMyhs/BEu/Se+J60i8TSCIRNnwIxE1z5J2ghRJ7cSeu+a5NJQ?=
 =?us-ascii?Q?Ahcnhe8mMvuouHExVmABMzQr5FYc3xAjhXqBX5Wea8exxLw1I9WbvNj2altl?=
 =?us-ascii?Q?SJl7Fcm/r/pPeex8XlU0IKH5oPn7yDMYafprTVwk5yyjDiuksIee1EBhGesi?=
 =?us-ascii?Q?zV/Xz8DngWQwJO433qZAsgnsEm5wUx9ORcafzOEe/ywvWWAXC65rFw0th99G?=
 =?us-ascii?Q?hadoG/ccvnH58x9EaCsIxeIBOGIldSTR+qorl2F47qrWPMzGdhTdkqaolQoZ?=
 =?us-ascii?Q?ozujhcpV6lsZM3L8syKQup2a3TkpGcBzfSjv180rW57APDj1xXXc+7wjYCdG?=
 =?us-ascii?Q?nD2vrAv2Phe4wAEO1o2tsmAXztSyRFDAfZ6TWZVcGA3wizoK1dwCVhh+kRcM?=
 =?us-ascii?Q?GQ3MxeBgnGI2YJEQtv8WWjyuGmazxPsDQsj/YbS7ziHzcct3nJT6z+H6Mpb5?=
 =?us-ascii?Q?+Q1LzqGloNJKSx4B3ydeguIcBwbrl3qPXrhANUCAdEQ2SAqkJd/rFyTOvobN?=
 =?us-ascii?Q?RhdNVNRciMdMZwEKdF8/Q/IuB2FMpcJ9au9X6N9/T8qOQx2raqYfELaBj10h?=
 =?us-ascii?Q?8EsosFvQPJDMc+46hpvaSh1pa9WgGlF8mdoRY69U2NiLyqIAyaGF5WQ3H/Ct?=
 =?us-ascii?Q?GXGsnMXI5siAPpJINY3b6+2n5jLKZTxY+lf+BQpXd7xFeTNZa5o2mQOR6DoC?=
 =?us-ascii?Q?upYilDYcJvMgSIRLn+W4EAcwhzdEP9gVG/suG+OTasfFXWrQ9EmBYeWLOOE0?=
 =?us-ascii?Q?x/30IXBz8I7ket7XNgy8wFGoQ4wEZ3cHrbt3tj9rUt0UfBpR7rcT7sxsr5t7?=
 =?us-ascii?Q?1Fknp/AGlmBm3x6DyRsn9Za6XiY//P1dclZzr075O6XSvDXZEIhoAW3hQB6c?=
 =?us-ascii?Q?UylmhQhFmInYarwQyJj+XBYxsxJwA05xp5WhJjSb2H+Oznt7lmqc1mwHk1VZ?=
 =?us-ascii?Q?6jvNbpL+KMsAJDGme04Mr9vZ6p7RebhFhfUkyVZlZdA6p5oWWczR0tDAfDTx?=
 =?us-ascii?Q?SsR/qOI6XWAxhTVDnwMGOz/mv7CAeZIazEQbcQW25DXdLfsqA2/qg8gCwUId?=
 =?us-ascii?Q?LAVl3fNCl5c8LXx4K/xvZI0=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 25dcbf3b-eaa1-41bc-8016-08de3d7f3d28
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:16:23.0288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7JPH+8J+sTAYOZrEj4y03oyEaVbi5qYutqIbh6/jBMv9RpIk4886HWr58jBLGI+Bj8O/0q4TIGJE0zg1cjkhKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4633

Historically both TX and RX have assumed the same per-QP MW slice
(tx_max_entry == remote rx_max_entry), while those are calculated
separately in different places (pre and post the link-up negotiation
point). This has been safe because nt->link_is_up is never set to true
unless the pre-determined qp_count are the same among them, and qp_count
is typically limited to nt->mw_count, which should be carefully
configured by admin.

However, setup_qp_mw can actually split mw and handle multi-qps in one
MW properly, so qp_count needs not to be limited by nt->mw_count. Once
we relaxing the limitation, pre-determined qp_count can differ among
host side and endpoint, and link-up negotiation can easily fail.

Move the TX MW configuration (per-QP offset and size) into
ntb_transport_setup_qp_mw() so that both RX and TX layout decisions are
centralized in a single helper. ntb_transport_init_queue() now deals
only with per-QP software state, not with MW layout.

This keeps the previous behaviour, while preparing for relaxing the
qp_count limitation and improving readibility.

No functional change is intended.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 76 ++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 44 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 57b4c0511927..42abd1ce02d5 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -569,7 +569,10 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
 	struct ntb_transport_mw *mw;
 	struct ntb_dev *ndev = nt->ndev;
 	struct ntb_queue_entry *entry;
-	unsigned int rx_size, num_qps_mw;
+	phys_addr_t mw_base;
+	resource_size_t mw_size;
+	unsigned int rx_size, tx_size, num_qps_mw;
+	u64 qp_offset;
 	unsigned int mw_num, mw_count, qp_count;
 	unsigned int i;
 	int node;
@@ -588,13 +591,38 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
 	else
 		num_qps_mw = qp_count / mw_count;
 
-	rx_size = (unsigned int)mw->xlat_size / num_qps_mw;
-	qp->rx_buff = mw->virt_addr + rx_size * (qp_num / mw_count);
-	rx_size -= sizeof(struct ntb_rx_info);
+	mw_base = nt->mw_vec[mw_num].phys_addr;
+	mw_size = nt->mw_vec[mw_num].phys_size;
+
+	if (mw_size > mw->xlat_size)
+		mw_size = mw->xlat_size;
+	if (max_mw_size && mw_size > max_mw_size)
+		mw_size = max_mw_size;
+
+	tx_size = (unsigned int)mw_size / num_qps_mw;
+	qp_offset = tx_size * (qp_num / mw_count);
+
+	qp->rx_buff = mw->virt_addr + qp_offset;
+
+	qp->tx_mw_size = tx_size;
+	qp->tx_mw = nt->mw_vec[mw_num].vbase + qp_offset;
+	if (!qp->tx_mw)
+		return -EINVAL;
+
+	qp->tx_mw_phys = mw_base + qp_offset;
+	if (!qp->tx_mw_phys)
+		return -EINVAL;
 
+	rx_size = tx_size;
+	rx_size -= sizeof(struct ntb_rx_info);
 	qp->remote_rx_info = qp->rx_buff + rx_size;
 
+	tx_size -= sizeof(struct ntb_rx_info);
+	qp->rx_info = qp->tx_mw + tx_size;
+
 	/* Due to housekeeping, there must be atleast 2 buffs */
+	qp->tx_max_frame = min(transport_mtu, tx_size / 2);
+	qp->tx_max_entry = tx_size / qp->tx_max_frame;
 	qp->rx_max_frame = min(transport_mtu, rx_size / 2);
 	qp->rx_max_entry = rx_size / qp->rx_max_frame;
 	qp->rx_index = 0;
@@ -1133,16 +1161,6 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 				    unsigned int qp_num)
 {
 	struct ntb_transport_qp *qp;
-	phys_addr_t mw_base;
-	resource_size_t mw_size;
-	unsigned int num_qps_mw, tx_size;
-	unsigned int mw_num, mw_count, qp_count;
-	u64 qp_offset;
-
-	mw_count = nt->mw_count;
-	qp_count = nt->qp_count;
-
-	mw_num = QP_TO_MW(nt, qp_num);
 
 	qp = &nt->qp_vec[qp_num];
 	qp->qp_num = qp_num;
@@ -1152,36 +1170,6 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	qp->event_handler = NULL;
 	ntb_qp_link_context_reset(qp);
 
-	if (mw_num < qp_count % mw_count)
-		num_qps_mw = qp_count / mw_count + 1;
-	else
-		num_qps_mw = qp_count / mw_count;
-
-	mw_base = nt->mw_vec[mw_num].phys_addr;
-	mw_size = nt->mw_vec[mw_num].phys_size;
-
-	if (max_mw_size && mw_size > max_mw_size)
-		mw_size = max_mw_size;
-
-	tx_size = (unsigned int)mw_size / num_qps_mw;
-	qp_offset = tx_size * (qp_num / mw_count);
-
-	qp->tx_mw_size = tx_size;
-	qp->tx_mw = nt->mw_vec[mw_num].vbase + qp_offset;
-	if (!qp->tx_mw)
-		return -EINVAL;
-
-	qp->tx_mw_phys = mw_base + qp_offset;
-	if (!qp->tx_mw_phys)
-		return -EINVAL;
-
-	tx_size -= sizeof(struct ntb_rx_info);
-	qp->rx_info = qp->tx_mw + tx_size;
-
-	/* Due to housekeeping, there must be atleast 2 buffs */
-	qp->tx_max_frame = min(transport_mtu, tx_size / 2);
-	qp->tx_max_entry = tx_size / qp->tx_max_frame;
-
 	if (nt->debugfs_node_dir) {
 		char debugfs_name[8];
 
-- 
2.51.0



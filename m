Return-Path: <dmaengine+bounces-7792-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DDECC92C6
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 19:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 570C9309F481
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 17:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A6135C1A5;
	Wed, 17 Dec 2025 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Bqa/RWBZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010024.outbound.protection.outlook.com [52.101.229.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E6035CB73;
	Wed, 17 Dec 2025 17:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765993807; cv=fail; b=rZMy0nnsMZdEZsnwF/hCwdLYDAckRv4XsBB4eBdqg9+CM8EGr3/3QGvc1QrR/+6xDid9YdMjlVDoxq+h5QllxAq5yMubF1ni30jISpRt2015eY5v7kWdGnAEhS8yKCkiS3h3ygApM52FhW1HsILorghFl82u+elm6zyu+TIsqYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765993807; c=relaxed/simple;
	bh=69e7PGsuDLmLY11yGAktC4/kimg8JqY4Dkne4IMfPXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=njqIDYVxrzvoEl3qIXw6ptN42/gH8OVNTB52XHUh6T9Rkf1mSgpe5nk5pEbjEDDGkEs+DoE2xkdiqHi+3n1bWrd1zlU5TmExvUV26lzVfMDWoPyC2gN2YASuxCfEetrIxQMNre2itl4aHK83kmlGOI2vJnJm2i2HLwp7fj7dklY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Bqa/RWBZ; arc=fail smtp.client-ip=52.101.229.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=me7R1AhE39NAW78zNN+pdNQC5S3gXFD7qvmLtiEbIYBodlOOeQbd6j7M0eqZMRD/vjJCak7xCWDt1U5+DuvCh7nTyXVTG3diC8oxXRRct11nV41u0JerDhDvcFshOIyeJk0zo8ikpbXLYg61Rii7wYR7upCypIfKywLyPiaI1e9XOMeY87HXu4G0cW01F5ZYYcLfILXzO8VG7r4xdGpFdIFE1Mm2km5BrqPiwd7KihGEra6kyWri3uceOyOfVtEQ5TPLyPWrYzgSghgHTCPDzybO7qp6w+aFem5Wna0VKNPlhvi1gcgjeofUAW4OOmyMfMAqltzJsSO2EeK5pS0PlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHnzD/I+IlEwwC0eTS/j4JzomLQ1b9OSgzbpKWYcbp8=;
 b=csTl0HkHDvHFT9g9iG0ev+IAEcALPAhLXsbUH32asT1IouetLdSCNtr+SHWn2hSh7AjdhMdWIN3bitPMP8BHkbcJQ+F/wPAO6cHrk+l7FnuPP6JE2OElsuMqd07uCpn9VYqvK1n6Y/PajLRWqV4v3TcpxMAkjgy3ww4m58LzDLKZuPHHEv9cE/AhGdPTCGq1AZ/YhvAuKrKCF0KJEXAqWmBF2Kd6zWKH7EpE9BN+0+AqlBe2jqZjbwt5AkWliwbhV65JOTJ3oAhlfq74X6uLO3iEMruhm3wWkK5ZaTqitIyYW/L0EFpLY2SacHvaNXl9okFtC9ABQpR81W6X33VWfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHnzD/I+IlEwwC0eTS/j4JzomLQ1b9OSgzbpKWYcbp8=;
 b=Bqa/RWBZVWjPL90XcpFk8j4dKnlhPVNw71h7eqHy9AEykLEIrN6bDrQ3FtqmMRvAE/RbRsFRQkhNspRdPqCGZK+/Ztlpy7t0XBu/wJJh8kIjHpPa3C/h7DCgKjjhS/DQjG5lMTdS1R39cb0QVL/lg3DcokyY2Qef4enrOqG399E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYCP286MB2863.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:306::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:16:28 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:16:27 +0000
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
Subject: [RFC PATCH v3 16/35] NTB: ntb_transport: Introduce ntb_transport_backend_ops
Date: Thu, 18 Dec 2025 00:15:50 +0900
Message-ID: <20251217151609.3162665-17-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251217151609.3162665-1-den@valinux.co.jp>
References: <20251217151609.3162665-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0068.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371::9) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYCP286MB2863:EE_
X-MS-Office365-Filtering-Correlation-Id: 60ec74b6-f929-4c0b-b470-08de3d7f4006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1JmMTZWJn8N3Ap2D1ywxPKvgzUGD4HqzucAu9FAfXAsQ55dqQ6n6HDQah+Rd?=
 =?us-ascii?Q?vmhPDb+CTxr8cBFv71Yjp/LoiJQkiTnotDrXP535xKdUDRqAk6eYU1yi6GOl?=
 =?us-ascii?Q?Nd82aaVBpXHYnqRJQZieqp9tTVBWW3MgFib5fqEJyh5hQoaVYb4wKtyk/lEf?=
 =?us-ascii?Q?cyLlTaf3xVxUNB0rjjaLx+ekuK2kIfSxKTt9wHrJew587iyz/jsN5HWpPyl3?=
 =?us-ascii?Q?/w8GUPkgAVOE0S2WrH6Yab5eCA5XhwuhCpScCoF8FqETQblPI8vaDh289MUn?=
 =?us-ascii?Q?0buHXFJ7HsCqKkFShYSKjGzhHNtPgkAB8YJOWbmNuYj0jpW8vf7SlB+6cbys?=
 =?us-ascii?Q?pYx7iFgKc0CRcyR06nr0gkE/qm4EzRTNwx97BNFikjlqJyM7uQ4qKGbmI9tQ?=
 =?us-ascii?Q?swjiS1CNIuyFl9r/nvMarZk8m3FtJXWT+bQ4+2amUlg0x/m2Dh4xYs7GMO6h?=
 =?us-ascii?Q?qv/rXl8wiWLtGdcoI/unjoYwLBfjb2WoVl+9p2b4A99BmdAovwbd4f2nGNzV?=
 =?us-ascii?Q?CaVx9oNV/IJhnCaruf4irUsPeSRtduN984hoK3YNsnzS8WqLNkT02Ff6MPgh?=
 =?us-ascii?Q?MFguvQtEM5HBWbnWKq9hiQNjliFMgikfEDzjVwdkdtYOFJneFYSLYpaoAg7v?=
 =?us-ascii?Q?CUB6YhxQj0f4mHaLt0fG4HLTN8PxvznbYTxxvyw1lo1xy+sW0mJLdfVq2UNm?=
 =?us-ascii?Q?qPvqgfArDGwnobu+OsY9jstFpbui4+NyOzmKih/mPs3tAs76fopIWDXCEz5J?=
 =?us-ascii?Q?X3pEKLZ9MlGJVEzjyRg0KweWC+pyYKHjedpktSZiDfsCS1zvrtR67Y4aAdh0?=
 =?us-ascii?Q?coLb7TafaMtQbb15MWp1bIUSsNZiOUrPi3ZZOk/Qm/R8oGVLcFHTp+7pldGf?=
 =?us-ascii?Q?HNZlXjsNIScYtXU5NymV74JRfPnXPeNMzfE8SWEJbn6Sxvd98ZzxbCe9CE90?=
 =?us-ascii?Q?lvH6zTj3GJqvJgSHR2uXxjyK5pU8Ehsalntefjy7QUtm4vvP5gRiQifE6yrH?=
 =?us-ascii?Q?JbTSWv3OVzQIWmU2ACQRPLEbi89zxm15HV5u9ToxsiSSccLgJQKXFpa/+5xD?=
 =?us-ascii?Q?XoxTKej1O5L2tSODx77INP9KgtMpL9OgeXK/DtOo6fuypJcZawuwfAeop+uM?=
 =?us-ascii?Q?LNBUPactUV2oSbQrF4SyRWNrIreZmmCeoj99H5USNj9B6G9mtHDw0K9gzlbH?=
 =?us-ascii?Q?vUHRNfOe6dM6U9naptBTgZ5lyy2T1lne2Eyo9LEyMVKNyvU3zWZm6dBxjz+3?=
 =?us-ascii?Q?R7mz079Y4sVFWEij6VjDa0NYI81JXxE6ns94UzblGrP7WR74wA+gTtMuBxak?=
 =?us-ascii?Q?5N8VNRzfF9D+J1ZkrtWeXL2G0QvjE2UiYdvZL9YJOOzY1j3ucdNLcalyQ7XJ?=
 =?us-ascii?Q?eW5znCqJSju8rSm78wyZ50J9/mBTWkdZsLliumqJE4jSIpz+WOFRS8R87TMJ?=
 =?us-ascii?Q?fHIT0a9lvOxrWMpLRsjPRirIoGvvaV8K?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jGo50AHuWssIImMF+YZUQj2cxCLWtTQ9TFabUBw92Vx/nufVl7wHPrgZqJqq?=
 =?us-ascii?Q?jxRdsruke5mZ62Be/5eh6iK9kEEISRDse2MS2Q8zNkNLyGE2hwESNQPP0p0g?=
 =?us-ascii?Q?lw7CGWOhTurseuV3ztzQdhSj4R7vIO6fK/818wCer1dZJcvQTzXNkMRmk73t?=
 =?us-ascii?Q?6kJK4xxg0fK9W3rMYKmYiy2TWev3YsnJk4W1BMZYc2TT1Rot+tEQlFGbUP3w?=
 =?us-ascii?Q?o/HJjIcj9WrWG/g0RSB0rLmmdxLu9nNsi31C1M0jUIrvL6VLn75jgtluhgFG?=
 =?us-ascii?Q?UkGtYbs3V+P1vSrmllKJLMyVY/7WUblAeIR72nnTfbIUmkKUHhq6ukErjv3+?=
 =?us-ascii?Q?+FxVJRqKWYWHxyDcXf/PynTk3h2S2i8/E9+8MLMNDkWRhO8Htgvbg0qRV1K/?=
 =?us-ascii?Q?tLnXnZ6A5Bhru0wEzjLggYAaZ6+V79W7zEafgQm2ugvbtu2GVetKdSRQ2BQT?=
 =?us-ascii?Q?4UwdI40ofwac6+V3uJ7UGwWX776vpu5Ps87Nd737s4SehnqTKxgBBrwncNih?=
 =?us-ascii?Q?krFiew3x+w4Hp1Tfwz07ymfVICLLmFLKAu5mzygfMv6644ZhZytTHvnwQtnR?=
 =?us-ascii?Q?LNVd2SWyvCzc4tT25z9QcDAFmItpfoTkqyVkAwc1kzgSBPAhjS/J/vXOSMPL?=
 =?us-ascii?Q?aIxglwhbmFT8RbbwhVLvzCsaq18EWRYyfxvGL2ASGLdJg4ZyWejkVTH+Fh+z?=
 =?us-ascii?Q?PllEQfB+EMxRsP5JbyYGaeIazykpbolSKW1et+L9pwQFEHk22hYFaaS4oIPG?=
 =?us-ascii?Q?w2F3o1dKQgmP9phxkF8WqHV7cwLLfi7nNPVkiWZ5ZF9/HBKN3XhiKnusvvDA?=
 =?us-ascii?Q?YftEZOdmtNvQoFc+Kj7BqxyncrGCAoEW3X4dvCpriCrhvHHLtVMVqff+2MaC?=
 =?us-ascii?Q?s3tnIB0zqU1yQjlgeF7wwq1cC3X5T1SVQmTZ1apayed2fZE9UIAwtVX2xfiy?=
 =?us-ascii?Q?aePBATskA/7gLacLXlUaEwtxJEhu+1NG9meNw8K4Vs8s5KVC1QHVqwLjv/0v?=
 =?us-ascii?Q?e0FGlWmfHmFCHjo039PcyPPnGgueONgFk0QrizM7sBKrpeD4GghkBN/Ze33m?=
 =?us-ascii?Q?5ZQ7mXvyN6aM5jKjkcUOb3I5nJKTNkv8zoVgmlJ4DLwLit5zYI+iME86jSwM?=
 =?us-ascii?Q?f+iQxsy2N7S8W7VQWrXmjXSPFgmzvaE/nQ2TwbbTSmoXMF4YU53kUjl+un+L?=
 =?us-ascii?Q?EcV2yGfw6fF5ZUcD0jgeCzKek9ueBvwbasdQpUwO/eYnp6nd8xS7PR6i5hsF?=
 =?us-ascii?Q?sD1vrjfBA8qZHQtBNy+AJGMaUkTVgh3KFdy0KoAeh15WzAl8LxTDeHQlnFG/?=
 =?us-ascii?Q?+9ktbWpjc2kRScfMXd0LrtC5A8uoBoIxjjGuRTaKEuudolPEoBs21JWe543k?=
 =?us-ascii?Q?6lFk4M5dDB/BRU/TR1urNTT91jewcbXDV4mmlv5vlzRBMnuwlY0ccVcrGpyG?=
 =?us-ascii?Q?rReCDIDcN5Zd7BwaOyFXXXA3yKgIgfybZOIHtwI15eOeb7lTEtDB0HkdQ+hH?=
 =?us-ascii?Q?A6TJPOFcYDsHR56FK0PhDExIgh5xobgvW7qN7SSdONCcxzJjS4x0wlu2eiU3?=
 =?us-ascii?Q?bOWDkmpe1zPeqFBWWPqEkshRlPCIBwLnZiLfhW9WlrNeWhjFm8lYjnUa/+w9?=
 =?us-ascii?Q?Q/bXMVm8fGHFPf/rZXbppUk=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ec74b6-f929-4c0b-b470-08de3d7f4006
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:16:27.8490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZCPwkVbfM01GNYgQgawYUpK3R9IPRl5wui5KarEH1NkUKQyW0Hz7Fnwx2aUfm+JJZcvJ4HfOImh77bco1DW2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2863

Introduce struct ntb_transport_backend_ops to abstract queue setup and
enqueue/poll operations. The existing implementation is moved behind
this interface, and a later patch will introduce an alternative backend
implementation.

No functional changes.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c          | 133 ++++++++++++++++++---------
 drivers/ntb/ntb_transport_internal.h |  21 +++++
 2 files changed, 112 insertions(+), 42 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 3969fa29a5b9..bff8b41a0d3e 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -348,15 +348,9 @@ void ntb_transport_unregister_client(struct ntb_transport_client *drv)
 }
 EXPORT_SYMBOL_GPL(ntb_transport_unregister_client);
 
-static int ntb_qp_debugfs_stats_show(struct seq_file *s, void *v)
+static void ntb_transport_default_debugfs_stats_show(struct seq_file *s,
+						     struct ntb_transport_qp *qp)
 {
-	struct ntb_transport_qp *qp = s->private;
-
-	if (!qp || !qp->link_is_up)
-		return 0;
-
-	seq_puts(s, "\nNTB QP stats:\n\n");
-
 	seq_printf(s, "rx_bytes - \t%llu\n", qp->rx_bytes);
 	seq_printf(s, "rx_pkts - \t%llu\n", qp->rx_pkts);
 	seq_printf(s, "rx_memcpy - \t%llu\n", qp->rx_memcpy);
@@ -386,6 +380,17 @@ static int ntb_qp_debugfs_stats_show(struct seq_file *s, void *v)
 	seq_printf(s, "Using TX DMA - \t%s\n", qp->tx_dma_chan ? "Yes" : "No");
 	seq_printf(s, "Using RX DMA - \t%s\n", qp->rx_dma_chan ? "Yes" : "No");
 	seq_printf(s, "QP Link - \t%s\n", qp->link_is_up ? "Up" : "Down");
+}
+
+static int ntb_qp_debugfs_stats_show(struct seq_file *s, void *v)
+{
+	struct ntb_transport_qp *qp = s->private;
+
+	if (!qp || !qp->link_is_up)
+		return 0;
+
+	seq_puts(s, "\nNTB QP stats:\n\n");
+	qp->transport->backend_ops.debugfs_stats_show(s, qp);
 	seq_putc(s, '\n');
 
 	return 0;
@@ -440,8 +445,8 @@ struct ntb_queue_entry *ntb_list_mv(spinlock_t *lock, struct list_head *list,
 	return entry;
 }
 
-static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
-				     unsigned int qp_num)
+static int ntb_transport_default_setup_qp_mw(struct ntb_transport_ctx *nt,
+					     unsigned int qp_num)
 {
 	struct ntb_transport_qp *qp = &nt->qp_vec[qp_num];
 	struct ntb_transport_mw *mw;
@@ -994,7 +999,7 @@ static void ntb_transport_link_work(struct work_struct *work)
 	for (i = 0; i < nt->qp_count; i++) {
 		struct ntb_transport_qp *qp = &nt->qp_vec[i];
 
-		ntb_transport_setup_qp_mw(nt, i);
+		nt->backend_ops.setup_qp_mw(nt, i);
 		ntb_transport_setup_qp_peer_msi(nt, i);
 
 		if (qp->client_ready)
@@ -1095,6 +1100,46 @@ int ntb_transport_init_queue(struct ntb_transport_ctx *nt, unsigned int qp_num)
 	return 0;
 }
 
+static unsigned int ntb_transport_default_tx_free_entry(struct ntb_transport_qp *qp)
+{
+	unsigned int head = qp->tx_index;
+	unsigned int tail = qp->remote_rx_info->entry;
+
+	return tail >= head ? tail - head : qp->tx_max_entry + tail - head;
+}
+
+static int ntb_transport_default_rx_enqueue(struct ntb_transport_qp *qp,
+					    struct ntb_queue_entry *entry)
+{
+	ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry, &qp->rx_pend_q);
+
+	if (qp->active)
+		tasklet_schedule(&qp->rxc_db_work);
+
+	return 0;
+}
+
+static void ntb_transport_default_rx_poll(struct ntb_transport_qp *qp);
+static int ntb_transport_default_tx_enqueue(struct ntb_transport_qp *qp,
+					    struct ntb_queue_entry *entry,
+					    void *cb, void *data, unsigned int len,
+					    unsigned int flags);
+
+static const struct ntb_transport_backend_ops default_backend_ops = {
+	.setup_qp_mw = ntb_transport_default_setup_qp_mw,
+	.tx_free_entry = ntb_transport_default_tx_free_entry,
+	.tx_enqueue = ntb_transport_default_tx_enqueue,
+	.rx_enqueue = ntb_transport_default_rx_enqueue,
+	.rx_poll = ntb_transport_default_rx_poll,
+	.debugfs_stats_show = ntb_transport_default_debugfs_stats_show,
+};
+
+static int ntb_transport_default_init(struct ntb_transport_ctx *nt)
+{
+	nt->backend_ops = default_backend_ops;
+	return 0;
+}
+
 static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 {
 	struct ntb_transport_ctx *nt;
@@ -1129,6 +1174,10 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 
 	nt->ndev = ndev;
 
+	rc = ntb_transport_default_init(nt);
+	if (rc)
+		return rc;
+
 	/*
 	 * If we are using MSI, and have at least one extra memory window,
 	 * we will reserve the last MW for the MSI window.
@@ -1538,14 +1587,10 @@ static int ntb_process_rxc(struct ntb_transport_qp *qp)
 	return 0;
 }
 
-static void ntb_transport_rxc_db(unsigned long data)
+static void ntb_transport_default_rx_poll(struct ntb_transport_qp *qp)
 {
-	struct ntb_transport_qp *qp = (void *)data;
 	int rc, i;
 
-	dev_dbg(&qp->ndev->pdev->dev, "%s: doorbell %d received\n",
-		__func__, qp->qp_num);
-
 	/* Limit the number of packets processed in a single interrupt to
 	 * provide fairness to others
 	 */
@@ -1577,6 +1622,17 @@ static void ntb_transport_rxc_db(unsigned long data)
 	}
 }
 
+static void ntb_transport_rxc_db(unsigned long data)
+{
+	struct ntb_transport_qp *qp = (void *)data;
+	struct ntb_transport_ctx *nt = qp->transport;
+
+	dev_dbg(&qp->ndev->pdev->dev, "%s: doorbell %d received\n",
+		__func__, qp->qp_num);
+
+	nt->backend_ops.rx_poll(qp);
+}
+
 static void ntb_tx_copy_callback(void *data,
 				 const struct dmaengine_result *res)
 {
@@ -1746,9 +1802,18 @@ static void ntb_async_tx(struct ntb_transport_qp *qp,
 	qp->tx_memcpy++;
 }
 
-static int ntb_process_tx(struct ntb_transport_qp *qp,
-			  struct ntb_queue_entry *entry)
+static int ntb_transport_default_tx_enqueue(struct ntb_transport_qp *qp,
+					    struct ntb_queue_entry *entry,
+					    void *cb, void *data, unsigned int len,
+					    unsigned int flags)
 {
+	entry->cb_data = cb;
+	entry->buf = data;
+	entry->len = len;
+	entry->flags = flags;
+	entry->errors = 0;
+	entry->tx_index = 0;
+
 	if (!ntb_transport_tx_free_entry(qp)) {
 		qp->tx_ring_full++;
 		return -EAGAIN;
@@ -1775,6 +1840,7 @@ static int ntb_process_tx(struct ntb_transport_qp *qp,
 
 static void ntb_send_link_down(struct ntb_transport_qp *qp)
 {
+	struct ntb_transport_ctx *nt = qp->transport;
 	struct pci_dev *pdev = qp->ndev->pdev;
 	struct ntb_queue_entry *entry;
 	int i, rc;
@@ -1794,12 +1860,7 @@ static void ntb_send_link_down(struct ntb_transport_qp *qp)
 	if (!entry)
 		return;
 
-	entry->cb_data = NULL;
-	entry->buf = NULL;
-	entry->len = 0;
-	entry->flags = LINK_DOWN_FLAG;
-
-	rc = ntb_process_tx(qp, entry);
+	rc = nt->backend_ops.tx_enqueue(qp, entry, NULL, NULL, 0, LINK_DOWN_FLAG);
 	if (rc)
 		dev_err(&pdev->dev, "ntb: QP%d unable to send linkdown msg\n",
 			qp->qp_num);
@@ -2086,6 +2147,7 @@ EXPORT_SYMBOL_GPL(ntb_transport_rx_remove);
 int ntb_transport_rx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
 			     unsigned int len)
 {
+	struct ntb_transport_ctx *nt = qp->transport;
 	struct ntb_queue_entry *entry;
 
 	if (!qp)
@@ -2103,12 +2165,7 @@ int ntb_transport_rx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
 	entry->errors = 0;
 	entry->rx_index = 0;
 
-	ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry, &qp->rx_pend_q);
-
-	if (qp->active)
-		tasklet_schedule(&qp->rxc_db_work);
-
-	return 0;
+	return nt->backend_ops.rx_enqueue(qp, entry);
 }
 EXPORT_SYMBOL_GPL(ntb_transport_rx_enqueue);
 
@@ -2128,6 +2185,7 @@ EXPORT_SYMBOL_GPL(ntb_transport_rx_enqueue);
 int ntb_transport_tx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
 			     unsigned int len)
 {
+	struct ntb_transport_ctx *nt = qp->transport;
 	struct ntb_queue_entry *entry;
 	int rc;
 
@@ -2144,15 +2202,7 @@ int ntb_transport_tx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
 		return -EBUSY;
 	}
 
-	entry->cb_data = cb;
-	entry->buf = data;
-	entry->len = len;
-	entry->flags = 0;
-	entry->errors = 0;
-	entry->retries = 0;
-	entry->tx_index = 0;
-
-	rc = ntb_process_tx(qp, entry);
+	rc = nt->backend_ops.tx_enqueue(qp, entry, cb, data, len, 0);
 	if (rc)
 		ntb_list_add(&qp->ntb_tx_free_q_lock, &entry->entry,
 			     &qp->tx_free_q);
@@ -2274,10 +2324,9 @@ EXPORT_SYMBOL_GPL(ntb_transport_max_size);
 
 unsigned int ntb_transport_tx_free_entry(struct ntb_transport_qp *qp)
 {
-	unsigned int head = qp->tx_index;
-	unsigned int tail = qp->remote_rx_info->entry;
+	struct ntb_transport_ctx *nt = qp->transport;
 
-	return tail >= head ? tail - head : qp->tx_max_entry + tail - head;
+	return nt->backend_ops.tx_free_entry(qp);
 }
 EXPORT_SYMBOL_GPL(ntb_transport_tx_free_entry);
 
diff --git a/drivers/ntb/ntb_transport_internal.h b/drivers/ntb/ntb_transport_internal.h
index 79c7dbcf6f91..33c06be36dfd 100644
--- a/drivers/ntb/ntb_transport_internal.h
+++ b/drivers/ntb/ntb_transport_internal.h
@@ -120,12 +120,33 @@ struct ntb_transport_mw {
 	dma_addr_t dma_addr;
 };
 
+/**
+ * struct ntb_transport_backend_ops - backend-specific transport hooks
+ * @setup_qp_mw:    Set up memory windows for a given queue pair.
+ * @tx_free_entry:  Return the number of free TX entries for the queue pair.
+ * @tx_enqueue:     Backend-specific TX enqueue implementation.
+ * @rx_enqueue:     Backend-specific RX enqueue implementation.
+ * @rx_poll:        Poll for RX completions / push new RX buffers.
+ * @debugfs_stats_show: Dump backend-specific statistics, if any.
+ */
+struct ntb_transport_backend_ops {
+	int (*setup_qp_mw)(struct ntb_transport_ctx *nt, unsigned int qp_num);
+	unsigned int (*tx_free_entry)(struct ntb_transport_qp *qp);
+	int (*tx_enqueue)(struct ntb_transport_qp *qp, struct ntb_queue_entry *entry,
+			  void *cb, void *data, unsigned int len, unsigned int flags);
+	int (*rx_enqueue)(struct ntb_transport_qp *qp, struct ntb_queue_entry *entry);
+	void (*rx_poll)(struct ntb_transport_qp *qp);
+	void (*debugfs_stats_show)(struct seq_file *s, struct ntb_transport_qp *qp);
+};
+
 struct ntb_transport_ctx {
 	struct list_head entry;
 	struct list_head client_devs;
 
 	struct ntb_dev *ndev;
 
+	struct ntb_transport_backend_ops backend_ops;
+
 	struct ntb_transport_mw *mw_vec;
 	struct ntb_transport_qp *qp_vec;
 	unsigned int mw_count;
-- 
2.51.0



Return-Path: <dmaengine+bounces-7773-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A65FCC8803
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 16:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43637309C1DA
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 15:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CABC35E556;
	Wed, 17 Dec 2025 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="MY+v1sWK"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010013.outbound.protection.outlook.com [52.101.229.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27FD35CBB2;
	Wed, 17 Dec 2025 15:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765984666; cv=fail; b=M8MtI16LYm3BtP6oRADIvjQUpeJJrDFPRexwcjRMr74HQHmNq/lurjqyPZvGfc4BblohM6RhfVFF/ulceDiaGGwZQqAX/87MflUs6lwFlTpeOR1fe9jnAXI8XQscBeZOO6CakGMCTcg5aSE9x7+yA6Kl+Y2jzPfClvbAb1108Yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765984666; c=relaxed/simple;
	bh=CuXA6CLx+C40qYVXl0sQLb+ak9zreWm8g+SfaoP5aS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gSqooDnxRQs2FrqnDgOfrGEcSfQajouhNWHjLuSc+yEyNIegXxSVbDhev3QFPtwQE+ws9YUQw6DgLw0+RQGbdq2cP7WzwmMtUZzp9aScbrK+4++3DxCzQOWfVR1SWO+gjv1puJuiBnJ31XoBrenrE/awI2Z5u7zmsBxSWaYWvI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=MY+v1sWK; arc=fail smtp.client-ip=52.101.229.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYXjbgxBJUohAo40vBiy2dlAiNSkW6UnK/FtwXe6Ipo30aGkLWWp5wUE4SyQs82KcR5L2v0Jt+V7McbIB24ymYFk3NkELLB9uGTY0kKhZ7Y6VzKAaN/TPZspdYNXA5vnqgrGwUaOp3dKNrNyTeOrNU62Yfzw63H9o+SZ0UHXAJ+W95O4lMLJu4NmGRXTJP4AddAMb3+LZKjbw42bLH77uf2z0EYwuKj/c9LjYalDOBvaLeBoDVtLoB4jc42y4qGKd4JpjjTZJLGuGCqbtSJMTzL50frYjhzNxwAa+kswx8RdupNPf+HACMynMJEbagMZL6feD996xqY9vS+6myjSAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rK4aS01haA71dFOZIC7AYLdaEBAEIhMDlQ8qU787w9k=;
 b=UZH3yB+WIyC/0TQxwMlaC1zdLiWvE6tmm8f8YZZm64jv8I+H9mcS+NZVWTHl1/umSZlPxiftQGgskcFCWr81zh3cVW8TkMM1abI4tvSIFb2jeNAQHZuKywLcYod0yBp9EnLDoPpyK9XUDKw0GklArrz+rYqFpZrBHTyAjhksBnB02SSIe6RG/ZGg0ODc8oDhxLR6srQbdc4hJLtYYtq6G3rVEKKffjWSousG/3bYAgiN2b8HjUHrzHYrqHWDSpV32/rYXN6iz+53EXhIyV7RAIIQitQbZGMH3T0d3ZPX9/xSeNh6Ex+WPfDwSvb+BWHI1WDDHPFR9AqCKpCtGV9DYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rK4aS01haA71dFOZIC7AYLdaEBAEIhMDlQ8qU787w9k=;
 b=MY+v1sWKqsjFCLf/JZ64+CuBE5cHLugAQG0kL/A1N4Fja1MCPS0FnbICeph2mlqe0Ga7b9/zrIdIFxsK4WX2GliMghnqki5UuPOoMMSKchdv1OaScPepnZGuIKBli/P5HVWcUnBSPOYO93c22NzPeohyjXSmb+0Yxx7wVTqJ+F8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYCP286MB2863.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:306::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:16:34 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:16:34 +0000
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
Subject: [RFC PATCH v3 23/35] NTB: ntb_transport: Split core into ntb_transport_core.c
Date: Thu, 18 Dec 2025 00:15:57 +0900
Message-ID: <20251217151609.3162665-24-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251217151609.3162665-1-den@valinux.co.jp>
References: <20251217151609.3162665-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0076.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::10) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYCP286MB2863:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f11b204-cfea-418c-0ff6-08de3d7f43f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ntOvK35RQbWAQklYOCr1JmX37kZ9gC+LZyXaDnRYu8yjOpaW2NT4oqv4vvVt?=
 =?us-ascii?Q?H6x4ZB29Xm5F2maPTyJehDLp5v1To6LDAXN3WMvsALYYBLVt5ec3KTUZodJO?=
 =?us-ascii?Q?X981NM1EtKbnVSubDUQvd5oR92whgzhTCl8WOc8B++ukxzy7ggbbqXpP0O/U?=
 =?us-ascii?Q?4npzlmnLw2fePchbQgyoS3bpSAQau2d7/O5tyRsxzPa67DvYSn7ZNm+Ld9gx?=
 =?us-ascii?Q?XjiMA9mWa7aQnhLHPJ1wBj2NSVL8Dk7JRGGBA7D50mCGNYU1pHfHXxvIjdUu?=
 =?us-ascii?Q?leG3ixsv8CKZMkuU1qlWZ94N63u64Anuxy6nrB27H9sA3D4ITs+q9HDRdSgM?=
 =?us-ascii?Q?jmhqiHMKjfKfe/9SYe7jtVjQdGG4CSJxDlEUJn/JuiwArmnHtNF/+k39v6Di?=
 =?us-ascii?Q?5Q1yl+wgqWbQmu9zdx8DRS47NCI1jcF0E/nnSlSCPiKCmV9P+jhuxOj3DSEJ?=
 =?us-ascii?Q?X9dINw47bAxMmF17s2+1DoJ3MRo3qLlAlyrwwu0grYjhffM2GB+5VOL0BFKr?=
 =?us-ascii?Q?YC5mLsYhDVSglM9H45czkrAgu6FjzarWPi/mSvc4PZy97BtohCyoMKpli7Dz?=
 =?us-ascii?Q?cnYT02rWHLuCdzdQGNjwX/9HJ+cLNLrImwBSl5+RYlEJjy0MjK9brkd/9GfR?=
 =?us-ascii?Q?SkHzZ7shQMzyUSffZoIWF7Z65xyNO2/dW3NH0faUyW9KwINHfmX2M0EfQqqn?=
 =?us-ascii?Q?gRykxRUDyms1E9rIB6zKJRzDrb4GvklOZ5SbM6K2BLe5cJjN+nKixyw2QerS?=
 =?us-ascii?Q?3TWpow+/Oh59IpuCcCAADu1MQ+EdasQddJ2JKB3kuIJzJ9GHXaVxz7fVk4DX?=
 =?us-ascii?Q?j132Bz2/PvR/YRksn1SyyFj5th3uEJVE2vcpRcJLRuFXczJPp4yISzjqLi2E?=
 =?us-ascii?Q?z531+ljyou4DUg8937b3H1Wgi7kHa2uilcCRN3aKTOXsZCkHWxCBmeTM79C9?=
 =?us-ascii?Q?+VLgI0284uw/Z1NGb1ZI3L/ufqIJtUU+AzeD4swiQ8YZdJ4ZlH+7eFQStpYG?=
 =?us-ascii?Q?ZcI3d/V6GmDUTH8pfIzRQkayxDLxfgxQawFmTtI89qH8mM+ikwJe9+YfrM1i?=
 =?us-ascii?Q?nlyt6TvyZrfTycPKHfKk96xFuxC8VGs3BU5kKKrWMspA9ZV7UcOrLn9S/1RD?=
 =?us-ascii?Q?wtKuVpuCs0WPg/HR6a8RkNpRgSlwL0mQu4Mv0UjCAq31B7P9FWsyir9gEYVa?=
 =?us-ascii?Q?oblncrUUjnSCCijHnpxEZf2zd9nQPuKBSys4rOvPszos+gzpIkpzDQ3bKo2j?=
 =?us-ascii?Q?s7XaRy+v96AXEHMrnJWCJJUetDORrRdbRLEkZCgkGfyyp2kZAz/uzJIMhYrb?=
 =?us-ascii?Q?IdCJgmlpC2UEx+KF8RMhgixWBuG5GU4tD+0dgqLijErjB6sfB+OZVG8TrUzy?=
 =?us-ascii?Q?zgM6G35e/R6pV0qLbP59g7JL6aJDzmIwlqBOVKzQYn8dbYHU26Eq3kknXVaJ?=
 =?us-ascii?Q?ibIrkOlunnEl1C0lPKd+FMeQTye5+6+P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rKFYMD/vJMihz7qpdrdWtDpo8GXwKaMHVRwAF6LRLG54yZbtF8sbpcNw7hvD?=
 =?us-ascii?Q?rX3sTpGuUNZPmTPgsDmYE82zS+ROBPdG1R796UXARGjycOwYmAtSq1M6pE2v?=
 =?us-ascii?Q?tZdtrq9sCsfclTehPo43udr73JVTzodeeBCFx/2jj2TRakrpK2lM+4mtPOY0?=
 =?us-ascii?Q?/Bq6eChXu9VNaBF3+BdLGGxfJLlrcsWhFzrI0Lha9w0YHAVXCf7XXIshSGhW?=
 =?us-ascii?Q?h9cf4+SMHOqVgcVMyagV47lstflUCRS0suq/MoIIcxboHTKZRp5g1+s94l6s?=
 =?us-ascii?Q?VIY5+2QhoWOwQyKTvMfqoUCc+1zRkhka8JbUTZRpxpqxi+HeTlwmq8xfkBbc?=
 =?us-ascii?Q?CwP2W6RJA9JPPO1xvkYe27wh35IhkG5BaCevwIkwJMnyG/TgCrVSUUHUY6hS?=
 =?us-ascii?Q?T5zJjApk57r8kMBkZsrj2a6b2aYMWhUpzHPF7e5UxWz2cLvkAGAuL371wm2R?=
 =?us-ascii?Q?cYZMIcfd3fs4pECt3utcb5KDfH0p/Ky2gOGvq/ckRnUR2WPYw+yv5kcOF8KS?=
 =?us-ascii?Q?KI7pA52eDtTPJeOleGwgf4SH132xEWbWPxkULnWh3H9AC4E9Y19IKu6e+vKj?=
 =?us-ascii?Q?TEYwRhXV/rJy75WcH2EFmcM5I0yNDba37Wz+X4wYq01HtQts7E6XNqstcHrj?=
 =?us-ascii?Q?qBwlpDE5/kVptE8QUUwYpfhL14qql3t2kEuFUKLD+cUJ6RGNtLL9ABeOa7Qg?=
 =?us-ascii?Q?Okh/qbMwXh7osIzd+VZhnEKjBPny3eer8LYBeOEk0m3kPK2Teyf3MdEBEAnc?=
 =?us-ascii?Q?2t+Ojv7WLO91RjNNE4r/GAiggpm8msHDJzBeepd8fwV9C7TpH2+JWYB1vQio?=
 =?us-ascii?Q?dlYbhPZUzDZW8pojiPJqQYdtxB1h44+9XZh9BpznDM3kh8HgWJ3ADNkrRXZM?=
 =?us-ascii?Q?wjxRpdMbv2JAtFAiM4OHrXXn0mpEVGhubhHjw/iFUj2+CJhremQXbKj4l6xC?=
 =?us-ascii?Q?TEjrHSmEnKLe3U3ClI38ShZwk0+adIK2sdyTVcyZyBbQqT2W8LrzZHt+Ervf?=
 =?us-ascii?Q?QjbriuPprhPL3Mgf64lKkxrNIn6WokFZEQ1kT5IwLTuLQlBdFHh/9gcX0mbP?=
 =?us-ascii?Q?QOzbIa/ElLe5a2/oikcWLKVdTq0CnYry1t/hmn7cJsYbDKTaa/CzJzdjPD/j?=
 =?us-ascii?Q?19p92kIBvj0GNpJfDHg3Tfwd++LleoyguWVKshnTBHvgNDCZU0Xtt40otzi5?=
 =?us-ascii?Q?+14sWwLyCg2b1vlSliQaBoYD4szg67kTXRnqMH+PmRXsFcEE6SzS3pvpA10L?=
 =?us-ascii?Q?2RHOO0ZfM4VQoS5EknDyjgsKnAUxG6JNXGkzifJRsz9m03kDkT+x218iLFnr?=
 =?us-ascii?Q?sfcbrHf3EilNYQr4kKhkJX8+eTqWcYhNTbM09M9pGw8N9wiuse8OKGw+Gqdg?=
 =?us-ascii?Q?jsF9hLT8vKTD9jYI2HD4fLdNaoigN9W/JVh4zSO6Aes6+9vCOp86ZPlSylcA?=
 =?us-ascii?Q?f21WqteXXphWRnf5gr7YIUacOjoNpokZ8xHgo/hXW91erl4K9Wlnfwa5EobC?=
 =?us-ascii?Q?/hP9eWIxCubP0oKwF1vr5UggIE9RcN19BiFVIEh+59CGkOEyb5GHGsqRHkfW?=
 =?us-ascii?Q?nBukxaZnDpvVtDh4v66jyAO/SJ5jL2A2SgqaNwnX2lRUbdtDuJ1aPYOevAIe?=
 =?us-ascii?Q?WUMXrBto4yJ7GV1//VDZZy8=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f11b204-cfea-418c-0ff6-08de3d7f43f1
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:16:34.3847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EcNSbd/T7rlgkAmeIKYIxskb2BteapPV2fel+I9qyoIufVZu7nF+DFX43HwyiBNki9bFLBKmOpt7ZHM/1jTIJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2863

Prepare ntb_transport for alternative backend by renaming the current
implementation to ntb_transport_core.c and switching the module build to
ntb_transport-y.

No functional change.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/Makefile                                  | 2 ++
 drivers/ntb/{ntb_transport.c => ntb_transport_core.c} | 0
 2 files changed, 2 insertions(+)
 rename drivers/ntb/{ntb_transport.c => ntb_transport_core.c} (100%)

diff --git a/drivers/ntb/Makefile b/drivers/ntb/Makefile
index 3a6fa181ff99..9b66e5fafbc0 100644
--- a/drivers/ntb/Makefile
+++ b/drivers/ntb/Makefile
@@ -4,3 +4,5 @@ obj-$(CONFIG_NTB_TRANSPORT) += ntb_transport.o
 
 ntb-y			:= core.o
 ntb-$(CONFIG_NTB_MSI)	+= msi.o
+
+ntb_transport-y		:= ntb_transport_core.o
diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport_core.c
similarity index 100%
rename from drivers/ntb/ntb_transport.c
rename to drivers/ntb/ntb_transport_core.c
-- 
2.51.0



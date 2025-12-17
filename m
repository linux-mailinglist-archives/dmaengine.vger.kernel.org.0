Return-Path: <dmaengine+bounces-7764-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 721B7CC8899
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 16:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1956A3144A90
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 15:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4EC34C80C;
	Wed, 17 Dec 2025 15:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="HiOSFIXd"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011052.outbound.protection.outlook.com [40.107.74.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1107834A3D9;
	Wed, 17 Dec 2025 15:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765984597; cv=fail; b=sxH0I0WL0v/lz4NKrOr+uQNU1yWYAGzi6sXkoqLVRPh2PALocf3vR7BLtQiKSPVE72FObqCC/XXw9/uecABWPVokWI9NnWMl7cjWzyEacvI25fzj3t0EeHV8CB54wHRxfuf+ThFoNwBGZyWF94kEahdRKKH5eNLAt9xzwQVB+tY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765984597; c=relaxed/simple;
	bh=2unACm8YuH5rg3Kr8a77L0+4xpOwH6gDn2wu0QO0SEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JcTDO4KMFel6inVn43BL19O/jyS9C+ZrgVwYvbWjshf4g6dnW8rEo+AZM9OgL4R1shY6OFRAgoLyV4meLzF6XQIkIW+C7qNsOdSM6vHJcZHUTVz0zTUBPyldolLVxKfFNnVGCwCXibhoNHAiYjhPdiDS/dJQQIrbxi6S2JEHdY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=HiOSFIXd; arc=fail smtp.client-ip=40.107.74.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aAKop0ASn98KTR1l49xCFJRLJQYxuasxwtE1vdGFUhimujmFnqMwFkUgFg304V51C91d3I3w+jXYF//dE8b5XIwlq2OLywxE+BAtqe5t6eONQkqClkamtcQiLb+yADI3aEMAsDFhKPzy/0iNJvtF8AGoCQ9qCLcEr0PLX9iac5rg2NCryvOaq7/EwfZ5EtJ+DaBryFZ+z0Trsuu1zwcXucpyNYtlt27ZO1Vyc4wv+p2IEIfyaod0Q0VngVKLq18oh0ojnhDRJP/8BbSlg2lWzdRyXl9vCkM0q2sP4AL7SvcNCclpbhPjd6esHY2gtCF6IaT7gqTPDAyo7i3EssoLJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXTRUMQYNz+2O0wAqrZ4c8/uym3gFTXkl1J+RoIWNOA=;
 b=Oh7Cpxf0CQvKvPU8v6DKOh8WWhbfbhoLZReVjj3wwmfnDkT9sqh1arvGYcePMqeJRrV79DD74dTtR/fwbI8HMjqYy0bZvKqKWznAAwzbdgL9TszKIx+bDdSKmTZxKS9NqTw5sYkLWlKS4RRcl5fUrgUayPV8+wxR1nPZc4suYwPko0//OU89gbaHYViF71pP7SQ32CKGxvbsEHJ54tfhwTWjA9cyDPnjD4Tslv9sExcaRJ7hGKpy52FdGcruHm6Pu0v5IubnNgWtATU783uRp0pMgK2Y0+iD7s4DDQOCMuQzB+K0Yne3+WaBiyXtWsUxtRSjoWRe53XbPGgzqY8S+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXTRUMQYNz+2O0wAqrZ4c8/uym3gFTXkl1J+RoIWNOA=;
 b=HiOSFIXdQKU1z8FfY2sMlBsppj+pgLJ4IIf83hWzn+BpRxCAMGt7vzx6qQ3bwimqVDMkdl2oFHis72qEEQIni1B86t7mEYKxiUTb0EEEDozczvf1lRARRyB8QVPHHrF+2Vi3HQ6nPlrzgXbLZMQicwgl1GCqCKtLzDRk1lPm5ng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB4633.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:16:24 +0000
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
Subject: [RFC PATCH v3 12/35] NTB: ntb_transport: Dynamically determine qp count
Date: Thu, 18 Dec 2025 00:15:46 +0900
Message-ID: <20251217151609.3162665-13-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251217151609.3162665-1-den@valinux.co.jp>
References: <20251217151609.3162665-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0060.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371::8) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB4633:EE_
X-MS-Office365-Filtering-Correlation-Id: 176a022d-266f-4e61-7bee-08de3d7f3dae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gwy32MFL3m0NECEQE3NVqJEp2zNSsccBSMuvKk7E4RZnp5uTWfwSnlboI2i9?=
 =?us-ascii?Q?JXULiawNx2BlHzI95WUOxr5kwjtkFc6/U0KwcEkXOeDJ5v5FEaGw5GjEWFB9?=
 =?us-ascii?Q?Qgvm2EnKO1+XdorSPnpkrvsOjH39YIDU+ogaFx6R1BtPPkWEzTgy3YGSvgOY?=
 =?us-ascii?Q?KAAdK4P62ZNRiRFPv0brG5WqXQBf+GXIzMQh0DTU7l33IfKuLuldc/jWflep?=
 =?us-ascii?Q?B/Ki9F7fBST9RHS5PgewIv34lgenDoMmUonsVym0HDHUfA++jwUxXkPDrn3p?=
 =?us-ascii?Q?pNM79qXlbi0EtkhF1/Lcp8pQasK2tDcZrYTBO7+Q2bOyU6osH+qeVbZpntIo?=
 =?us-ascii?Q?nm96jxOsmviL38W2havyGPhZpVHzKypGSCw7pJQ3sioqvE7nrOVBAzsw/5as?=
 =?us-ascii?Q?alzLMJHnAh7TkCtcdcigVdVocwWFZKfS5CLAR05DyO+rp96neuJLG4xaIuML?=
 =?us-ascii?Q?of6w1IauFEMFmGhbne5Jbk/dapUOx8ZNeFHc/4+2s+d+NlyU7kBSAMzaeIVr?=
 =?us-ascii?Q?cLxldBM3B+4d7A0Ma7QlGxWD0Ofw0XjCkamlvmrIPdQtbngUjN+jSskzy4Fy?=
 =?us-ascii?Q?Mzr1dbUpZkjhjW2ycXdcvxS5RGvc3lpYHi5KzFbsSNPjxV3PzQr7RITYcM5i?=
 =?us-ascii?Q?29OEYRUIn0SNJ3cbpxSbrH+jsqkpVXbmftYou5RsGK88PIwdKYXHlsc/LaCs?=
 =?us-ascii?Q?H+R85rUCGdmJdDDLEkR8vONCWC2LSwmJ5XkBKOzlClQOCfHrF1D/JgEWsPfF?=
 =?us-ascii?Q?NBQakLa6hWJZQWbujPbGJkmlGW5bqp36VF5ABSqessxYOkgdt/kK6g+fz3mr?=
 =?us-ascii?Q?LY3nfWdoxIVz4b9hzrf9UQMPXjyck4cearxQxGu5C9+eyEtnnYejo9h1BlEq?=
 =?us-ascii?Q?Nw3DLXmV9+xrgxlSlnnglXWkYy0vkVXV4SkVUdcwc3pu76X57cDZNrtqP87I?=
 =?us-ascii?Q?Zv9RqlhaFRHyt28+6w1aIEhOSu1mz1qyj/LCEcLJMC4YCTN0sgR3RLD2qysX?=
 =?us-ascii?Q?zrKZlF5rGgATy6/xGvGsYXJ/wbsnBJAQGUyaFp+epfLM/9zf7ovz+i74TVyw?=
 =?us-ascii?Q?64KzLQvc0bojtqNxOKCfC6vuFfQEQc2mKwddsF1mc+3UVf1qZ2lS67bJVkrE?=
 =?us-ascii?Q?BaohPHckwCesYGdE/Om80EQHh3ZRJgCybUGpbDNDA5+LGVojI1FAvgNN1N4N?=
 =?us-ascii?Q?J9TekNQodP2sjkQfEXNiz3N1OyBR94xjVkalbd5zdpsGEfUM55iRFZ47OQ7P?=
 =?us-ascii?Q?O9h56KzjTrok852HbGbd8oin3+WvQGE0rNVLuxUNXPRSVDG4zS8hFPDbJKwP?=
 =?us-ascii?Q?/nA0uiLrk5xihHvla4/vSj35EWdSIN5pHfr8+OfQvavNANawqbgzdJ5ojIyR?=
 =?us-ascii?Q?K4L/vkY6EUWf86zJRzBN5+w36XJ8zkOG+hmOh/CiW5lNGbOFe+tRjPCVhxwB?=
 =?us-ascii?Q?9koOvKCFWjHkIxkYjUfOlBvI+Atq3jl9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4rVe7t6siq6X9JYH2tB5Pqwtx5czrVFXToLiufLbiMrrc0AASFFkJ10y1sjU?=
 =?us-ascii?Q?guSuqlBsfRJ2k2Bv6QvzeSh9oQiToje08/Jdg0DNcHUu1ELEtQt/CKVE4jwb?=
 =?us-ascii?Q?A5GSwQ9csN01JWQCdNlHoISUW5vblMTdRRftgNCVsra4fU0JGqqDm+c5FThZ?=
 =?us-ascii?Q?kiXtnhvsfIYwdD14giz0qFmWJU1/0s20mYiXgSFrfrxXWl1B1DednidUh9ZN?=
 =?us-ascii?Q?J4x0pWYi0FalipulZlJZlQRXeRERTAot0psj+o6No1B0AWtbOBWXyI60tR5C?=
 =?us-ascii?Q?ULlPs8ul86oY7x6qRuQwIWSjTc5xGihyLes/mEO4Yqq/+14xjIBLJAzcjoo9?=
 =?us-ascii?Q?l1Y+v/ZI/JWGm5R8zVaQIc3wf42Rhp81KFyTd8lr1bVj7zv0s8Qin8k/U0wy?=
 =?us-ascii?Q?BZPIl1KFeFUjQkv46Trr5U7O2rOMHeTxwUBXCqb5GvJrS4kKj5+nobreSC1d?=
 =?us-ascii?Q?mCqAgg+ExlkjNRSZTabB/5/Nq3BH1rIpo8zo/kuGkaPiAjw7h0Md/9IRPSBp?=
 =?us-ascii?Q?in0Vd5uc99K8d1Ror23dChAAGgYyVMWAg4jfqL9Y3NOr+oHsnbDErAJSuoX1?=
 =?us-ascii?Q?nmEg4PWQ5qitMV8y6OBf3VbGIV0ooMifEF6DImJdvcbJatRZePdbv7WwwzrC?=
 =?us-ascii?Q?LPNeqbcmTDv4NBCHy6LKrJgpZOqjRZIW3NamACc2leRy/F0GJuAsxfh/s7JW?=
 =?us-ascii?Q?tO1yahoP4qLMGwbE5if/udeEd7EkLHqy6ou5FtlRPmw1UJoyLtKEmABkxFRA?=
 =?us-ascii?Q?iBxe6JnL2UIIMZWGj4isjzIk7+kpMC8C51MXQUc6V5nWLvMYOhZOxF6osneD?=
 =?us-ascii?Q?SS0uBJz1aibAv4D2VGGoMzE/iq67nemX416npyHLe3neV92Mm/IUtIt38vU9?=
 =?us-ascii?Q?xevAPv88s5DJKJIXl6L7vPG2GWFEE5HWlGZkJk5D8SGudse+sXs9QfqjQQlw?=
 =?us-ascii?Q?grSf2cDx5qr2cLtmu052xt+jS9KYVKSMoiMKNUoDp3lOViif3MhZ39h8BSy9?=
 =?us-ascii?Q?WKu/IYZxf1RIBHbMvSHlqFImhfzezXDL7XcVU2DZvs+KwKrirq3/XKlwkH+5?=
 =?us-ascii?Q?NdgYNKGySWcmghKOBPa0AVIUgqGQ9M3BWNWF6u/JtiwTMXJaBBUvBemYXR2b?=
 =?us-ascii?Q?QadlcsNSISGD2Ta5sXn11OzCLXJz7Eb0HeXmgB+SauRV2TwA5+GmJN4qQ/qZ?=
 =?us-ascii?Q?Pw4HUhhcVIBcxvrbjUD5gGsJCldj6WXwvIRFkPGCFGJlCYFxAqeaTsvVa28p?=
 =?us-ascii?Q?Tj/P1ZmWQSWPCYIn4yjDbwzOP66aIrE2lypRwGWnSYJ9PsTWi/gExL5e0vOG?=
 =?us-ascii?Q?+YxVPWY6Ff69sMd9us0/3KrEjcGFTmp3O6ojb44T0bk4NqP9wLghd2Duk9Y4?=
 =?us-ascii?Q?uG0K9cjPK135oWhcYE93jheKNIgnQGTmk2pgW/bBzywrx7pEklpCpuScmhf8?=
 =?us-ascii?Q?I8O/8xb6dzj5mdzEU1IBzjS+8L/MpthwyADj6zD/3z8Z/ZXUAYPqCdMR/D0B?=
 =?us-ascii?Q?XRMSV1rhLQPMOAsR4kEmQClC3BD7xU0M33OCf/C3fYJVvqurGvtTLiJabnNh?=
 =?us-ascii?Q?78dBAG55bFfGOHgH6rgcYSSP+9khVVmZEx2TRYEdtwxCth31V/3mU/f7Niy9?=
 =?us-ascii?Q?cErmPlwBqcG80OsYuQztQ6o=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 176a022d-266f-4e61-7bee-08de3d7f3dae
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:16:23.8878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Akg6Oy3McoeNhSUZZPoSh00F2ux/+oXV3ksMUREc35l+A+f6MDiRMaVbA+ASyVPhBojJm4TWu2XSotxuX/x3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4633

One MW can host multiple queue pairs, so stop limiting qp_count to the
number of MWs.

Now that both TX and RX MW sizing are done in the same place, the MW
layout is derived from a single code path on both host and endpoint, so
the layout cannot diverge between the two sides.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 42abd1ce02d5..bac842177b55 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1024,6 +1024,7 @@ static void ntb_transport_link_work(struct work_struct *work)
 	struct ntb_dev *ndev = nt->ndev;
 	struct pci_dev *pdev = ndev->pdev;
 	resource_size_t size;
+	u64 qp_bitmap_free;
 	u32 val;
 	int rc = 0, i, spad;
 
@@ -1071,8 +1072,23 @@ static void ntb_transport_link_work(struct work_struct *work)
 
 	val = ntb_spad_read(ndev, NUM_QPS);
 	dev_dbg(&pdev->dev, "Remote max number of qps = %d\n", val);
-	if (val != nt->qp_count)
+	if (val == 0)
 		goto out;
+	else if (val < nt->qp_count) {
+		/*
+		 * Clamp local qp_count to peer-advertised NUM_QPS to avoid
+		 * mismatched queues.
+		 */
+		qp_bitmap_free = nt->qp_bitmap_free;
+		for (i = val; i < nt->qp_count; i++) {
+			nt->qp_bitmap &= ~BIT_ULL(i);
+			nt->qp_bitmap_free &= ~BIT_ULL(i);
+		}
+		dev_warn(&pdev->dev,
+			 "Local number of qps is reduced: %d->%d (qp_bitmap_free: 0x%llx->0x%llx)\n",
+			 nt->qp_count, val, qp_bitmap_free, nt->qp_bitmap_free);
+		nt->qp_count = val;
+	}
 
 	val = ntb_spad_read(ndev, NUM_MWS);
 	dev_dbg(&pdev->dev, "Remote number of mws = %d\n", val);
@@ -1301,8 +1317,6 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 
 	if (max_num_clients && max_num_clients < qp_count)
 		qp_count = max_num_clients;
-	else if (nt->mw_count < qp_count)
-		qp_count = nt->mw_count;
 
 	qp_bitmap &= BIT_ULL(qp_count) - 1;
 
-- 
2.51.0



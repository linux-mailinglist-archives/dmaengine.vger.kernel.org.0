Return-Path: <dmaengine+bounces-7788-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D80CC8EA0
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 17:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6CC03011A8E
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 16:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CD734A3D2;
	Wed, 17 Dec 2025 16:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ZlKLYduP"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010014.outbound.protection.outlook.com [52.101.229.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B3C2BE7B1;
	Wed, 17 Dec 2025 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765990257; cv=fail; b=F5dN8JMDk04d/XrJH2xgzjqmt8aDhISFdHw6ySLb2dj3aaUcxK+sHflfMj9IVjGkTeldghqMt0ouaKtSp5vXFvKfJllhDOD7IvnapVhDK6usVJZr6PdStwnWBdDUou/zsAWQaMJAGcntdYs45qTfa8GUzRUelVr7T4zU3rnM9Ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765990257; c=relaxed/simple;
	bh=hsgWHebgbZ7qaNTh7eWfnVKFa5C3pnSOqRVD7sIEvLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i1O87xso8RkMIJYAV/hnwJPbOsjflNZ0DTFN/lgsNXYejFCj7ZRe6QjjvkG56YFaJclqlubxu4NI+Ouxj/U0CHjIypdRVkvYvoFFOqb3HNJjbFR4/eUKyqaF7aN7dgS50YoAlpGAySiVzTxaNX1PhO2rTgrmzGkgrKgD2CUVmXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ZlKLYduP; arc=fail smtp.client-ip=52.101.229.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8KmA8tOU2e3DjUBYKT6FaCzYSrLUNJ0txQqNId5rdCTr9xiUw6BrgGLWoRBg3iEr3Ic9FW19WRJhfhwLMtC3jxSD+bIrdnJuVO8Asmhbvapt5U/RQ3i56+Zia5fa4Pg1YkjkH+pe7yK44SZ6IgZHL9F5s7Pf0BjcoREk2JHCsqs/v1vkzeGLkNcVysJkb12MvyPh3/f6qWw2BL0/2Ex8gB4DOlGYtWOZIGc1ppVheR839AUpNVlDoKbx3OQk4GJesl7mSq/KnOEQS9/XJOzsuAONvAZuy6fL8UIcYa966abxS2qJsoeuJ1438Dr/MsC4WR4hIIcvAckm4/O6NRSpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIxR6FHb6BD3dwk32/h4Ah/ip1PqsRaKSxFcTmP4GPI=;
 b=ZSXvuWpuMvgn8s3Ap3EO3HhjlOPGdNPwXlOJ32ZguAHvWDkH9Ec9lsq8wRqExNjv+fCN56dRLwoSNYXHAnvrpGw9UPZo+kLbB8eh+2kq6f+5U2slOUP8L1CKZq0QSgvVzP9lsD5JS8vHEGIOqrT/RRseEB2NEW5U1rvDWBRPjI1Vg8dwN16oS8ZC+yqb2JHExcKp439QQUiCuqkB2SNHI1L0aQmAySIhKuY5SOa9kX6RQ8ji7emC08oRV3X192guGpIQVtBOtdLd4GfDLYZD9TsqOx4V3ES+GPJ1dOdX4miXfhBLi/hDxWfK2bejjkf2f/8vF4UR0BuxlYrfvLQHxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIxR6FHb6BD3dwk32/h4Ah/ip1PqsRaKSxFcTmP4GPI=;
 b=ZlKLYduPfTWFKfzJ04KJcl55IsD6MjFEaD6XXP67URWyRUg+62jVtQKbvHwP70nYjeIdyZyYH1gp2l8H9WcR1Bw8J5GM05fWLpSWnIjBA0j9W5niwMzPNjJtG2vGhFV9vRZRzNdzPyA+7fHV3i3a7ifTWXkcotd+VYvDQM/Alm4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYCP286MB2863.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:306::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:16:35 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:16:35 +0000
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
Subject: [RFC PATCH v3 24/35] NTB: ntb_transport: Add additional hooks for DW eDMA backend
Date: Thu, 18 Dec 2025 00:15:58 +0900
Message-ID: <20251217151609.3162665-25-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251217151609.3162665-1-den@valinux.co.jp>
References: <20251217151609.3162665-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0295.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::10) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYCP286MB2863:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bd2cec7-1526-43f4-e6cc-08de3d7f44a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v8u+jxhTgvZfXg7xWwkC7bAcpGX/RRw2iZL29BPKWYfNYeaON4fJVdzKj7so?=
 =?us-ascii?Q?hXHuyFn7fi4HQlnSqfpWeryZAP6wecfJglulXznvZfSwT0njiUUhgmYQgU6W?=
 =?us-ascii?Q?7eoPOdZWMRedQtTv9pmg48b3Zht5W6qxfDLgVDJHmJKTha4bqsXDcYjemT7H?=
 =?us-ascii?Q?TegcRpJhltOvC9s8d1CUF+4XIV8xbWRXyUhv6nCt8UJ5WtxNkfIJlA3KVNrE?=
 =?us-ascii?Q?NPoC31NsGw0xjxuz6xakpDPWQhb/QW6xq7bRA3dhfQaFFs1arpY4HmCacJm+?=
 =?us-ascii?Q?pHSi5xiicMVpol0whkZKxdidDtVbFDZd2qedGcrhGYM8OcG6G5YRXNjOeJc6?=
 =?us-ascii?Q?DuoJ1kjPr5frww7Dqw96ePX/mk5RvYqzs+ZULdHeAatQAs2JbJRw7qrv9ASF?=
 =?us-ascii?Q?ZX+LGTbwqeYV65vekR7ktZb5dVFXdrHyAsGHmDgK6vrxjzwLuZ6+XvsYQorN?=
 =?us-ascii?Q?bo41faqB8wAKAXmuQ3yp5+ONUx3QmWNxSphyaoR8R9/jPgwf77K0KQm/Uo6T?=
 =?us-ascii?Q?bSNMvZYFvEDud+KyW6e9L6QnyGVxBGuZe9D8FkWCJHAb5zlNOTexxKNnTWrJ?=
 =?us-ascii?Q?c30c/QyDpkWqB5KNPiJq8E5tC9Ew2aWHZS9q6Lq+zuQe5gf4HLqFvyS58bsj?=
 =?us-ascii?Q?oV8BudyxTzyAcvq8uwmt7SXNojeqKBKyvkkOKZzAEZEBWu/d2aH62PBQ552G?=
 =?us-ascii?Q?tU4D1K8h7wwsM0DfkUoojleuU/imo7+hbNNJcdoyUxBQY8Fcrggxs2DOsusp?=
 =?us-ascii?Q?KW4bC4l0BI5r7TLrJlfrQOATwvYaM/ea79N4zKz7o5QG/oxA0UrrkRyKLYL2?=
 =?us-ascii?Q?nBTKEIdIDJVqJiRsl5QH3rUN2NfWPXWUv0S1zuIuHVCnPVVspakOIDXJ8lQi?=
 =?us-ascii?Q?pAm+vWBwL6HXozm50Opnk0eROTD8Sn4HB7aT+bLW973w52EZ9tbV06X0T1KQ?=
 =?us-ascii?Q?tznL3U5fxa/G5TgIa28rKHRTu3SLePcu7+l0F5QzwDNhvLLEREqEA213m7sP?=
 =?us-ascii?Q?YSQfMuGR9gYEcvF33JlQ+5rcY3xZf4Wfu55Pk0WYy+rpISVdf6m2E662IimW?=
 =?us-ascii?Q?GP3BUiPXM5tXijFWl7wfLg2Uq7jSNMsNh96CviCvucjfJesIPt9WIPu3qv+L?=
 =?us-ascii?Q?NdM8rL1+H/SkA9rFAvWbTnAElkNGsvr5W96ZSwlH+wT55cr4a/hCmcyAy9dj?=
 =?us-ascii?Q?NUFMUbZJ7GXZIn8HHSTCrTpenCT9u4IwYr7V3DHJPS6nNdn9iKu6pUrQhyGa?=
 =?us-ascii?Q?/6tDYWdgslKHW9UY/pqScq469dVTgiinL7KgPwCnG6MxtRtKufOWlVjUCySf?=
 =?us-ascii?Q?wBJzmb4gzP7dgoySLaPDVvc40PGKmVXA7mTn0Gt0SdKLuoD8n//UmT5yMRsX?=
 =?us-ascii?Q?yNdqlG7gj+Ls4Ao3wq9KpOVoNmf0i2WCmWSSsgcGfsQh3dB36LkUPAaYOsJj?=
 =?us-ascii?Q?Bs04poth0iGxnHy4tZlGN/qNXInp7Rxs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PI4yBi82Q4LcY8nKrjCPpcMZAacLMcRnJWN9n6KW4DWRHzC+Qc6cGlX1DXf0?=
 =?us-ascii?Q?QyeTdvIHSNX0SaFOyw1V9U7RJDQ3dkpmDQBp9Gdk+fFrvAFY4DKep88o/7oT?=
 =?us-ascii?Q?N1KrX+BqE4buSikosls2cTdwQvfflU1soEEtFmZr27z/DX2kRWtR0zQJ7Ane?=
 =?us-ascii?Q?DECvf0cyMzDkNhPqxYQkRmSdsbek2vW0rWyTOmTTyWv34leO2nz9+YD/mAcT?=
 =?us-ascii?Q?z4JRdgYjL+YauxkLAEbk5hBYupMwKINzJ8FoCIlBTNtoCjlZzixpQ8KheNjw?=
 =?us-ascii?Q?7ySxjsP5e4xHJJ3ZfmNxz9mtQfFRBIDt532+EALiJKDwFQo8oJ1PPnMavium?=
 =?us-ascii?Q?wS90XqzQWUH+UbiAIVAh3nFNr+5SThpb02VI6dcIxudiQvdYOZXaoP3Scyx0?=
 =?us-ascii?Q?bHZ+YCCH9gD0E0rDlScIBXA3Dn8DP+CkiXU/XUieu+3QZJQBtqws55VvNSxW?=
 =?us-ascii?Q?Q69O+sE2jb0L/PcZ7goLG7Q4wD8eB/1Kh2iMBHAxePzbpHQTAtdZ+VazMvR3?=
 =?us-ascii?Q?BslQLPHfFIpER7SCb07QOTEep3D4xfN9XnqMwaSe3LfWNliETZ4Kbg4MZP6r?=
 =?us-ascii?Q?eYM40Q4TkcbtgktuQ+Brw4wN+oFA7HZR21rT2jg7Y6hCfSMVoYsn7UBWC0Yc?=
 =?us-ascii?Q?k0HeuQqTEmXDpsk2hnA/S5NUp04qpkDOgkQ1rYFyGA7nx5gtOZFGEqiHyMH/?=
 =?us-ascii?Q?B/BPy5AbHxWz9GiPYcBE6fE3XbUX+RX2jWo06jA17J5vOyYIelp3sr/bXZec?=
 =?us-ascii?Q?IKZa98dBd3k24W1dFlRLjHq+V5RDOZDo1qf1ZH8ylr+B/g0WYTyWnyT4uYFX?=
 =?us-ascii?Q?qzAuSwWO/tDx9d523t7ROtTjsxmu7WoVqCL78RTvRUZrtXowUFEJ2TzRjuJ/?=
 =?us-ascii?Q?5enJLjzJhtRorEDoV1JUmRoIw2OxlccRQMAEPyRUEHA+uTFhAjEKk+J0NJy/?=
 =?us-ascii?Q?3vY2sqxxteiftz0VVbW3WyTxHuNNlAtnASt9jWg8EXBDUtBLZOobIn2S6NNB?=
 =?us-ascii?Q?0cyZdYWb9vY4Es8/Jir8gz4m2jA2MX7HRtEGiFenIjDO6/vHzI4uKxtYLUjY?=
 =?us-ascii?Q?ifYppf6uVz4xKB7U7QCovvFGYMhLkRKmdWMLvv1j6EMYjFxYd1+OCsi1Fqk8?=
 =?us-ascii?Q?oXAYFgAPlj8VlW1FxXEKzOS7HTFhY9q50VxYvzhw+84kJcowXn1XKSiD52QZ?=
 =?us-ascii?Q?McSrZBcrUq0JOxUx9zV1bNMRwZAeMoUgaOrul3MYWC+yua/Gxft6fNf5KYJl?=
 =?us-ascii?Q?2J9Y2+7TDJz/v3H1JcaueKGI3ars0svixaEZJZ2GXWZUWpYgP6BXkRR1F2tE?=
 =?us-ascii?Q?1ZEbGYbcncv+cn+0TDW5DnyfsO7M3+nOntTLdezwaXlzDN3nRzoXaHydpp6M?=
 =?us-ascii?Q?8DmWm+qVtCY+RSRNBsh79w1VYw1vZe851ZrIc1DFAIqMzLcxhgzt/vYha+6K?=
 =?us-ascii?Q?TSqyYKcwQr1GzagCheCua309dw8lmK1OnHiundCraVUaFhwoTuheSqUSa7h7?=
 =?us-ascii?Q?dfUmgRH2JPJxKzjo/IDCkyhJ/W8TYQM146LOendb1SjaYKMhywbidizNt3CT?=
 =?us-ascii?Q?Sr1RDoNOO5qSSA9sqLbEqjn1D1jwMZ1LbSeOChqRsaqA7CB/i/ffHvh2Hmzc?=
 =?us-ascii?Q?B7AFYzpsNMsaMs/0xjz2bk0=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd2cec7-1526-43f4-e6cc-08de3d7f44a3
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:16:35.5548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6FZKB1fsYGu+hH6yE3w1gF2RcNGPMhaL8dwoetOR3FaLkAc8hEkA0vOqRhkXdk8O5npXWfXK48kinVJOj99DPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2863

Add the infrastructure needed by the upcoming DW eDMA backed backend:

  - add hooks and those invocations
    (.enable/.disable/.pre_link_up/.post_link_up/.qp_init/.qp_free)
  - store backend-private pointers in ctx/qp

No functional changes.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport_core.c     | 34 ++++++++++++++++++++++++++++
 drivers/ntb/ntb_transport_internal.h | 20 ++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/drivers/ntb/ntb_transport_core.c b/drivers/ntb/ntb_transport_core.c
index bff8b41a0d3e..40c2548f5930 100644
--- a/drivers/ntb/ntb_transport_core.c
+++ b/drivers/ntb/ntb_transport_core.c
@@ -879,6 +879,9 @@ static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
 	count = ntb_spad_count(nt->ndev);
 	for (i = 0; i < count; i++)
 		ntb_spad_write(nt->ndev, i, 0);
+
+	if (nt->backend_ops.disable)
+		nt->backend_ops.disable(nt);
 }
 
 static void ntb_transport_link_cleanup_work(struct work_struct *work)
@@ -915,6 +918,12 @@ static void ntb_transport_link_work(struct work_struct *work)
 
 	/* send the local info, in the opposite order of the way we read it */
 
+	if (nt->backend_ops.pre_link_up) {
+		rc = nt->backend_ops.pre_link_up(nt);
+		if (rc)
+			return;
+	}
+
 	if (nt->use_msi) {
 		rc = ntb_msi_setup_mws(ndev);
 		if (rc) {
@@ -996,6 +1005,12 @@ static void ntb_transport_link_work(struct work_struct *work)
 
 	nt->link_is_up = true;
 
+	if (nt->backend_ops.post_link_up) {
+		rc = nt->backend_ops.post_link_up(nt);
+		if (rc)
+			return;
+	}
+
 	for (i = 0; i < nt->qp_count; i++) {
 		struct ntb_transport_qp *qp = &nt->qp_vec[i];
 
@@ -1178,6 +1193,12 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 	if (rc)
 		return rc;
 
+	if (nt->backend_ops.enable) {
+		rc = nt->backend_ops.enable(nt, &mw_count);
+		if (rc)
+			goto err;
+	}
+
 	/*
 	 * If we are using MSI, and have at least one extra memory window,
 	 * we will reserve the last MW for the MSI window.
@@ -1267,6 +1288,12 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 		rc = ntb_transport_init_queue(nt, i);
 		if (rc)
 			goto err2;
+
+		if (nt->backend_ops.qp_init) {
+			rc = nt->backend_ops.qp_init(nt, i);
+			if (rc)
+				goto err2;
+		}
 	}
 
 	INIT_DELAYED_WORK(&nt->link_work, ntb_transport_link_work);
@@ -1298,6 +1325,9 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 	}
 	kfree(nt->mw_vec);
 err:
+	if (nt->backend_ops.disable)
+		nt->backend_ops.disable(nt);
+
 	kfree(nt);
 	return rc;
 }
@@ -2021,6 +2051,7 @@ EXPORT_SYMBOL_GPL(ntb_transport_create_queue);
  */
 void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 {
+	struct ntb_transport_ctx *nt = qp->transport;
 	struct pci_dev *pdev;
 	struct ntb_queue_entry *entry;
 	u64 qp_bit;
@@ -2074,6 +2105,9 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 
 	cancel_delayed_work_sync(&qp->link_work);
 
+	if (nt->backend_ops.qp_free)
+		nt->backend_ops.qp_free(qp);
+
 	qp->cb_data = NULL;
 	qp->rx_handler = NULL;
 	qp->tx_handler = NULL;
diff --git a/drivers/ntb/ntb_transport_internal.h b/drivers/ntb/ntb_transport_internal.h
index 33c06be36dfd..51ff08062d73 100644
--- a/drivers/ntb/ntb_transport_internal.h
+++ b/drivers/ntb/ntb_transport_internal.h
@@ -106,6 +106,9 @@ struct ntb_transport_qp {
 	int msi_irq;
 	struct ntb_msi_desc msi_desc;
 	struct ntb_msi_desc peer_msi_desc;
+
+	/* Backend-specific */
+	void *priv;
 };
 
 struct ntb_transport_mw {
@@ -122,6 +125,14 @@ struct ntb_transport_mw {
 
 /**
  * struct ntb_transport_backend_ops - backend-specific transport hooks
+ * @enable:         Optional. Enable backend. Called once on
+ *                  ntb_transport_probe().
+ * @disable:        Optional. Backend teardown hook.
+ * @qp_init:        Optional. QP initialization hook called on
+ *                  ntb_transport_probe().
+ * @qp_free:        Optional. Undo qp_init.
+ * @pre_link_up:    Optional. Called before link-up handshake.
+ * @post_link_up:   Optional. Called after link-up handshake.
  * @setup_qp_mw:    Set up memory windows for a given queue pair.
  * @tx_free_entry:  Return the number of free TX entries for the queue pair.
  * @tx_enqueue:     Backend-specific TX enqueue implementation.
@@ -130,6 +141,12 @@ struct ntb_transport_mw {
  * @debugfs_stats_show: Dump backend-specific statistics, if any.
  */
 struct ntb_transport_backend_ops {
+	int (*enable)(struct ntb_transport_ctx *nt, unsigned int *mw_count);
+	void (*disable)(struct ntb_transport_ctx *nt);
+	int (*qp_init)(struct ntb_transport_ctx *nt, unsigned int qp_num);
+	void (*qp_free)(struct ntb_transport_qp *qp);
+	int (*pre_link_up)(struct ntb_transport_ctx *nt);
+	int (*post_link_up)(struct ntb_transport_ctx *nt);
 	int (*setup_qp_mw)(struct ntb_transport_ctx *nt, unsigned int qp_num);
 	unsigned int (*tx_free_entry)(struct ntb_transport_qp *qp);
 	int (*tx_enqueue)(struct ntb_transport_qp *qp, struct ntb_queue_entry *entry,
@@ -166,6 +183,9 @@ struct ntb_transport_ctx {
 
 	/* Make sure workq of link event be executed serially */
 	struct mutex link_event_lock;
+
+	/* Backend-specific context */
+	void *priv;
 };
 
 enum {
-- 
2.51.0



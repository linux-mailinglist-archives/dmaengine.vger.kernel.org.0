Return-Path: <dmaengine+bounces-10835-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJdEO+71E2puHwcAu9opvQ
	(envelope-from <dmaengine+bounces-10835-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 09:10:38 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8CD5C6F3D
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 09:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C09430131EE
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 07:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2747A3C0610;
	Mon, 25 May 2026 07:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="VbqFv3At"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010042.outbound.protection.outlook.com [52.101.56.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F403BFE50;
	Mon, 25 May 2026 07:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779693030; cv=fail; b=UoWw77DwfGINHbJCXPf6Dtb3dUbbAXTx9V4Hmlgf3SnfNhgAE44QS5BXVOrsBr3KML5mLG0nyMfllARjcY8xNSt8YnacSrGQRWFaMAHgFS4UYUDiAcJhCDn1GJgGD5IshAtWt8KzqPaOD5Kdb2Ms8BRebpCrA5DAMFPelImXCxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779693030; c=relaxed/simple;
	bh=PKzIPL3W67hXs0/bRymUU18UwMJ7EoW9U1VvyeXU+DU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=M4OQJtpHLor7o/2fm6+omWhlXC3LYB9hTepHsU42hbYivMSeRFeAR6nAAwsX1TO3tupZStVusC8CJqnRzy5EMkhuQBY1K2DvL3xzeVwRlCNEgzm4UGjHzVT/Pow/cn1796fYAwH8Qt/rxu+NabTG2Q7qqL8YQqFBzhghjhy2gVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=VbqFv3At; arc=fail smtp.client-ip=52.101.56.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efCtfw3YFcV8MTH2rfWNHin7XmwLCLMUVjtiYixfLk2SxEFVIupJ3N+UBGXLD368wxychJ8XOpVAk3BEcHIFeKjL4VVQWxLJrwvMbP1hvkVZXkHvj4bUYxITCO9mElIS9ELPjmn48oXGCBAg26xzAQTOh06qy0My0RDzWnO8L/sdCS2ZONNQ0vHevbKJwmY2cbTGTu415T/6IYhe9LGU0Lz2jISHSi6a0ktLbjFSFp3WaNg1CA76xp2sk/jVaz3j77wh1OKRiEAkzgA4xXBgUs458ZyvOCmBMX/07Oylp5/L/1TBkq6cVf/oFMnT5nh8ZM3nC7jOE9FnrKEKPSwrSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+cXSKUk/17XIOrc451vjYzghMrtog/gsx7qeCsAe3U=;
 b=HCDCC1FQuPN/CesE7zBNSv4jb+q1huM5LgCjrTLHO5w/g3dCnNGf+mBkb239sGHDE1bDukxBE+cIAy08ZVUx6GP9MVBF8i95bOC5bxEVSnuPUn4Xk1c9cPD88hLen6sY+Sclca8TlFXD7WiI0YvicuyusO8FTYWI/AyW99XyM4qXadJiaSEUgjOwbTX5pvO3b6t8Q8blhyjjAcxbmB2EIVQNLq5YZTEAhm0BCoq/YIR2yTLSo89ty97pICZWPDO5V/PNE96c8Kat+fgmYrXaD4ctzhsfPsp6XCskRVtJjgJz7ohZUBoGA55iK/KI9G5Oq6d8BKruIoNzWHH9132nBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+cXSKUk/17XIOrc451vjYzghMrtog/gsx7qeCsAe3U=;
 b=VbqFv3AtZALCeNBtQfDU1BC8b6aicAlhiYFrnJuTDb4wbnBByF86GhHwzboLs++zzdFZ0rBRtIW3oGv91zYltcfBMX7X7Urk45bemlkNnuoksICG1jkJVPxUwkLUXFvgT8OVaBNU3tYCPz1ZFHS5Wmd0DaxJUbolMqD12did29ulEAzAmqz4xrVgnRIsK69UpXHct6RI1DwpbSymI18rmLw9HOsRhk7O5kgR+TK/25F/t1Aa8cY0qOQ0acxyojkzbssbepTDUQuRxswE89fzCdOaFPtwhzTq/+j7w/JvdTgiaOfh0cuDBBu4B+uABYlsd0RU14Ams3+C1J0HusQjXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by IA3PR03MB8456.namprd03.prod.outlook.com (2603:10b6:208:53c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 07:10:24 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%4]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 07:10:24 +0000
From: tze.yee.ng@altera.com
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tze Yee Ng <tze.yee.ng@altera.com>,
	Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>,
	Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
Subject: [PATCH v2 0/2] dmaengine: dw-axi-dmac: clean up DMAC enable and PM
Date: Mon, 25 May 2026 00:10:20 -0700
Message-ID: <cover.1779688569.git.tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0107.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::22) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|IA3PR03MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a514ff4-96e4-41fb-e538-08deba2cb0a4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|55112099003|18002099003|56012099003|5023799004|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	11S+JH9PEUOoRzPUmfPQ7q1+KUz3E95+4czio6hvWSz4IBjdeRnu+kvHAne6dLqGi4MxSsZav82+wElV41UaJ1Rc6VjWd4Y2bNy1b+7BsYqp/AvF2hjCqDEZCmxtVHuklqgnDepvAYNojtEnP6F6plvse53tU7KBc2yMyypEzyp03C8X2UuxoI4aeQe1REg6hoDgdK/JseQ3nwflh/srgHolckfC04rLIh21jEFppUiGhL2I8Zxl21DpaoP0211Z5askYPKBjmx1I8x8WzzZIXuPW6NTbI1GKpNPwVlElQNxzhbv+fExUKnQYD42SGEJ9fPFwadz/DS1+oh8tslU1pOSQOM8zIjqmhm5i0iOK2ftPyeyGRcWf5hp04S6+mIJ8ugnFsXHXXkvPe18Vk3gU8HxNe71vhkQ/SN1ZhZLWiXkrkZFkBfFVcCfJoWu/ORP1EGFx5nmnQ7HyMIPhBn+o100stK7+9oCUq/o6UIdmRRqJZa9EtfEN4vmGonnBEsFyQveBbOFhJXUKpYghqRD60hiaixpUhDKCnvtXNISn5H6enwOlHGtFhAmTvctnQlKxSAkxr0bgVNsIzPn4SngJ3myM6sCIhp+n5EfzB3HIUuhxrIfKJJ8hmsGripJ8MVB/aCGfIiMtREJHrzE3HVwzWob3SQZssY9nRSERMgaufjS8tFor58VTIGENxx1rawG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(55112099003)(18002099003)(56012099003)(5023799004)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8+Q1CknihaMv33NzlxRX25X6mf+MeIOLAroHRj21Hids3Tr9E/MlsSitkgj8?=
 =?us-ascii?Q?JNsAbLbozRMqXTem7uKVolTYAF3jtCMW4FodQXyB/+z5JR9S03ohDbeak+Wp?=
 =?us-ascii?Q?7a3LN+CGkbVR3onCJFfmj+t97XiCWoe9lwAeKQ8QyfwmeiUrd8u3gUl/Y1hG?=
 =?us-ascii?Q?RQ4vjFBuGheyX56umn6Ue7pNSKj22IQQy/zQ1b0SXdnZeOqCFFX67HSp9/XZ?=
 =?us-ascii?Q?D8MvHvOSpzgfcwQKomyxMzQygMvIDerWp24vRxvO70XjkkAah26F80pFSkgc?=
 =?us-ascii?Q?FrT5hYEBRABYsRagEavsKXxtYkkwJjs6/0/fMMgTI2SY43hiEXoxI3+gML43?=
 =?us-ascii?Q?dbXl8sI16qCyLRKOzS1i1z4aMbvOjHpNTqCEx+/t0xQnPBkDLYhPUfkraj7x?=
 =?us-ascii?Q?W0gbCFSsyPgOrSJkkknMWMLgZR1Kq4mJzTERfpH37j3TQ9i1YRjfHlbXxcue?=
 =?us-ascii?Q?CA5uuEq8Txpg14R61kRHLj9hOGqj9LqOpcOuKVfvVRkuepDwVvwfsjR/0nOI?=
 =?us-ascii?Q?vMhgl27Q/jQ2N8VA8T6+2PnfRkTDgvS51psAIaoZGDNiJ9/tSlE7UExrfQpb?=
 =?us-ascii?Q?anXzBv9L+haZeiPZS83DooYF6rwGMA1Dk9glRX9Wr1Os/HMkLv1Q6e6rRMhU?=
 =?us-ascii?Q?yOk85BIrl+gdx6efpurqYz+PPUHSrM5NmrECjPJiKK9Oe81rA+BvC9hzJMMp?=
 =?us-ascii?Q?cnWst5Fbcf14j1clDMbjsQnU/XghPFU6ctd0QCMQgJKnWOp2D8PN8xZdGg6s?=
 =?us-ascii?Q?IyRVORHbEDTtQNRujfhGCleHae44XNRP+Vks0N5uxmUnb6DNYBcU5lTYxBrn?=
 =?us-ascii?Q?9TsAJl0NyXhLBeDRylXDFVLsqiS+y7HCvZph611gxG17vtfNdnXfAXBTjtMp?=
 =?us-ascii?Q?A6VTElmA7p0uYSD75j/Jh5aueB0Du92zWrd7eDeOg1NovwlMANna3j0+xUfV?=
 =?us-ascii?Q?9JsCSWKRVu6kioLFAzRFhj9DuCr/lKHaiwYoq9sQubtRG6TfRtE/S9x6ymuu?=
 =?us-ascii?Q?1mFOB9/AacSzKJMBcrYKKCTW/vBGmRGN/h9z+WHgNkWu6415U++c5jLxN7pR?=
 =?us-ascii?Q?cN7CvkFL4N6F9VjVoTJjeXeSd+wDyE5FzO51LXez5YBPNwMJE/AfBPIoOpie?=
 =?us-ascii?Q?y1+jkwUH6zmB6GIs6C3yGkgdngux63S+lYTc+0oGelSbvhzRAk4na5IyH0dK?=
 =?us-ascii?Q?QV5Kcs739DT8mdsVBRbiJNWt4gxU124+SKLRzT+L6QK4cGADkIn6QHGxN+/S?=
 =?us-ascii?Q?d10mRvPgKbWhieY8xgFlbR8xrbrpINcoJOkC5QVGTbglo+yFnpyDc9T+bFLP?=
 =?us-ascii?Q?E+j0r76lTF/UDq+CTukvl7xHsgncdKL+xxquj0xowqb2Q0cH41qEz+6DtW2+?=
 =?us-ascii?Q?NUaANzYdrTsbqRW5bdg6j565iRmnOjMy0XOpsfwEEdEQYah/BcaWiS6VfWpA?=
 =?us-ascii?Q?EliQRFV7K+T5PnLdcaUOc052Z7dPz0XWLtt4r6aspMKYEptmjBQ2i5zfDctP?=
 =?us-ascii?Q?9DxjDW3pUiJuAHJ9DHbIQOBpRwPN/n8ZMG2qhWq0PRMbNB7LMUAVD3bvjU4J?=
 =?us-ascii?Q?qj2dabN8xRSQzmURA0LI5LVZsDEniFMs309IKGOy59tXP9BHR23IptqDJ+pd?=
 =?us-ascii?Q?IURyrm16YyS+vlYvDgZ4+qm07WDnD71Y+FxUEYX1bNAvZ1JLNDMeT7f8a6eF?=
 =?us-ascii?Q?sVfHbCSxzIp4MyIdn+Qfh1vBUlEtxUrkPmYmlRZCpBZFVejbSUNQqv1cG7C/?=
 =?us-ascii?Q?oeMNSoXOiw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a514ff4-96e4-41fb-e538-08deba2cb0a4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 07:10:24.0017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r4FSlCxIHe3+FOkhx9cc8w5C2uCCvMR4LZT4U7SLlUjtdB6KZrjOkdHmyd8tXK7KDi+MmbSY/Mk1htpEviwm5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR03MB8456
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10835-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[altera.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[tze.yee.ng@altera.com,dmaengine@vger.kernel.org]
X-Rspamd-Queue-Id: 6B8CD5C6F3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tze Yee Ng <tze.yee.ng@altera.com>

The DesignWare AXI DMAC driver enables the controller in axi_dma_resume(),
which is invoked from the runtime PM resume path and from probe. Calling
axi_dma_enable() again at the start of every block transfer is redundant
on the normal path.

That extra call had also masked a gap in system-sleep power management:
with only runtime PM callbacks registered, a channel could remain allocated
across suspend/resume while the runtime usage count stayed non-zero and
axi_dma_runtime_resume() was not run, leaving DMAC_CFG and clocks out of
sync with software state. Removing the per-transfer enable without fixing
PM would make that scenario more visible.

This series drops the redundant enable and adds the missing system-sleep
and channel-allocation PM handling called out during review.

Patch 1 removes axi_dma_enable() from axi_chan_block_xfer_start().

Patch 2 (follow-up to review feedback from Sashiko Watanabe):

 - Add SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
   pm_runtime_force_resume) so system suspend/resume reuses the existing
   axi_dma_suspend() and axi_dma_resume() paths even when the runtime
   usage count is non-zero.

 - Replace pm_runtime_get() with pm_runtime_resume_and_get() in
   dma_chan_alloc_chan_resources(), with pm_runtime_put() on error paths,
   so clocks are enabled before a client can submit a transfer immediately
   after allocation.

Changes in v2:
- Add Patch 2 as a follow-up to review feedback from Sashiko Watanabe.
- No changes to Patch 1.

Niravkumar L Rabara (1):
  dmaengine: dw-axi-dmac: drop redundant DMAC enable in block start

Tze Yee Ng (1):
  dmaengine: dw-axi-dmac: fix PM for system sleep and channel alloc

 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

-- 
2.43.7



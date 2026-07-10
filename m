Return-Path: <dmaengine+bounces-12269-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mPFtHx6qUGpV3AIAu9opvQ
	(envelope-from <dmaengine+bounces-12269-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:15:26 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA228738540
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:15:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=DNyuOGP6;
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12269-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12269-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B0A53007E39
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D453E3177;
	Fri, 10 Jul 2026 08:09:16 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020075.outbound.protection.outlook.com [52.101.229.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE2139EF23;
	Fri, 10 Jul 2026 08:09:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783670956; cv=fail; b=pJV539pol8IdjoJoI+HWPKT6Tu18v1se87nfs4ez96LCKTgaN671tqs9nhErvRgQ17VCJfRvtZIYfDS4lM5L06JZBdJD40xZFOa70uS203PvJ6otE3Vs4XRmrTwJgY6kqNsnYM0j4XeJ6UjoI3hF5aM3tZ0hCfFKA+ezQhc8bmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783670956; c=relaxed/simple;
	bh=ukYfJ43tUHth0XGcK6gQNqMHiWhbnNR/f/kfX/pKsQM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hl8NLOdIO/G1sNQwVaQPSdasIejDEJ+zLI63RoCC1pJcYEFBv00/IxKtIFxEyEStqJ/RGdLsswOtYzMaYzHRE6STVK5C/Kc04y26iJQVfxKWl4EA19jUenUBqRzbTr7r53XxuAu40ZtDDn4IMMXmL3ET8DKvuqOsnnmXu/6PdZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=DNyuOGP6; arc=fail smtp.client-ip=52.101.229.75
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zEkTKP6XrWj/QJYtZZ1vevUO552B7i9WCcSigvg1JN0IVo4DaUnhsQjlVDjNeN6frP42aqj9TXmF88atKOzzeHaKoj71MFIJBvUvs+BAGWMZvGs5wV/k2QIvZXKVSYjS5F3AilNEdBYIH8Fo8S11rTd85MhT1JQp5GkdrpD8wnI5/gl2S3peA0hUT9y7cgzgZAQZTVT6wpcHcHYaTvX7zJYPIdiC6l/9813HkDRtlARJ8Bl7tsnlUGxboI0073v6Ls8aqUHaij3/CgH5Pj3OwH3ktdaZXbNKZhLFWbB6VJf2d5+3EjEr6c1290Fql1XeR/HZ4HjDAXvpF4tp7Age2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLDHD/HXHXB7CYpeYu6DI9X/Gn5Y34YtS7bNMQVDt0U=;
 b=GZAvqirdKAMnIn7BlfFszQLQTf0FF9Ny2OY82XEX1O6xvt4yqtqzIByK2jfPyNgAC7K3kZ1HjJyDkevo+gLaXhYGJA/ZVxaiOhEEVNS8VvKpSxjNpvs+PLDyBK35U0C+5hpcaK/a1F2QQ2dIF7Bdco0lQ/+BK9UeCMzKHutDfvihrDUJDozFIJn9MR6KECoTcZKbsY+C9LkswQWF7lezHuBEvgmmYsG5uOFlAgdr+IT7EhZpIlJnt0mODtbBz6MaZSlVT6N8vFkz5qOxTV+7bHcJXi2zlVGfC+6/qY9Ss9jHV/mLiLFqmxfHUQ2bbx0RLkOwNEq3lhuYJBf7ZRA/+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLDHD/HXHXB7CYpeYu6DI9X/Gn5Y34YtS7bNMQVDt0U=;
 b=DNyuOGP6LoWokNYeI1ty12ytwCvukGpJ6303Aa8nv7vf05sxcITPwxZdIGUnTUy9YqU0eCasGv2Ito6nPIr/7N7I7n2AbQh8b+IPyzmVWLaWvY1GVZ1DrguggpIYcsC4fCbrX83lQ6z207EQ572Oih0/yhpR6WVzwmfh1+glw98=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB6374.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:32e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 08:09:09 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 08:09:09 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Serge Semin <fancer.lancer@gmail.com>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc: Devendra K Verma <devendra.verma@amd.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] dmaengine: dw-edma: Fixes and interrupt-path groundwork
Date: Fri, 10 Jul 2026 17:08:56 +0900
Message-ID: <20260710080903.2392888-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6PR01CA0024.jpnprd01.prod.outlook.com
 (2603:1096:405:3bb::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: aa7f00cf-6f18-4cb3-0324-08dede5a852a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10070799003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	Tr40UzumNuv5PT5+My3MId8qhESkIJTe+5rakB3bl/b3XoYKWvpjUNwdSL8MncGLvll4f8OwwWeKPRWjowof9Z98DlMd2tQ/LRzVndauCxOluS/zciMmQ6Ct2Mdmu115gWLSq1PKJGlCKCjzHZ1Tluobbtz9RipHjXbTpZaemeMbVw87JSnEfRIrpMX7LLs732JEmcgyh5xuj1vnO2q4b/k8NZTnIDYn05u48FFQkgaUFov4yAWvp5C6wCNLkKcTZcBpxXC6NDkAzlIKXClbt5+LqQ73Mbzaqnco+JGOJnLsa/GpJgkw1pUVJHxcE7vl0hV0cUuimT9gqzWE/Dw93DsYNFj50c4hpRDRS7ZlW9bQOUVT4S+FegaU+rfX26loBL53Wux3Lo2W/a6VAG3dAQjnSuCos7iiiuko6OTgH6vMKW3yF6xAmYpC5kgGasKVrmECEmPVwyVa2g3QBazTo3TBUNczQSOwscJrCmdPAKM95BycC1Bp4umSa1pzpNW7ZOtcI4HvZDBrYALXe170V52JxXY47UoaeYBazSZ6KY0vIaZtRmxRfHhzaCL0QUn0G9NBvl6RHx9hpsh5Wh7qGwDmmx7r9aZNAiJ4J9MGadgM7ldS5f1inP33eY1W5uJtW+YYKNXO7Twc6LP7dTUa/UyZ4YIY19Ezb4cglFCzSUU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10070799003)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y45I7mUVUjsnzEtLAgAAkUUazGmFnZ+ue4Pz6ohstji+bltDot+0ysYBlYVX?=
 =?us-ascii?Q?ZgCBjOXQ75sCbLikA9HIH9xK7I6PJgusai+42uZrrypJUcN2iRB6FcMztIX0?=
 =?us-ascii?Q?lZx/HvnPR9Pte72CahhmAU7j9+IZoWxaA1IBB+g0Z3NVoGAn9OHaDj3cq8Uc?=
 =?us-ascii?Q?EvZvnOnZetVjC/SrRpNuUiAMWtNoSccCCRT7DFmgsDcsAA21Z6dVH+U2GyS3?=
 =?us-ascii?Q?kgNV5KvJ61Un06MsPTZPurKejCm/6S5WgO4ZPjpqCYvfzUeOXyBSSsd3ER7A?=
 =?us-ascii?Q?tHwtYlcqG6F0sx+ISAJuVuOxlR68WhDDWuy3bqWT6X6ns5a2GDbFNouVUueF?=
 =?us-ascii?Q?/qOc/USikDbvAcVeW6BQFLQGKKKGHHEQetextQh8JokWAzLFZQvOW4vitl8l?=
 =?us-ascii?Q?DVtLoky6miRyOF84A1Cow1rZwiY5KqIhXtmoxBgfRaMhS9mODmKWz/02yNTi?=
 =?us-ascii?Q?0RQthdtL4/eFeOq9azVqhHJIAbj7i2RhcuF1Wxc8Bg+1qT64O7ZblK9b2oNx?=
 =?us-ascii?Q?xAvejoGnISCjUqJ/KeiuUmIFlYecO00o9tIamxqfxEZCVQyk/a0/GnagSqyH?=
 =?us-ascii?Q?qlKgoIGZ5TOc0Nsb22p8Fwfq8TxM3Jcvr+deeFgDLAS9C4Q70OuuYM7OKGvV?=
 =?us-ascii?Q?cfkWRd0+IwjEwBJnsA1Laa+TzoSikyRUklxQoZOirl19VpOTkTApV66fhEU0?=
 =?us-ascii?Q?yTD4RxU65tFd1vrdpaVDsVE5HUjws9w0ew/HVWdWZnQoowBOGwh232DmrlRR?=
 =?us-ascii?Q?cOIx8N1o2fi3QpL7EPyJ9AHQ25E9qjMhb/LoQiKpvJAwQA2nB955A5jU0MQS?=
 =?us-ascii?Q?0qFKGLMYBPolX93UWM329sY8K5SdVPXObzDZDNxrmMe+tFnHwK7u5mX4Y/FR?=
 =?us-ascii?Q?uF6XwqLvayXncLg81rL3YkCv/I9fnwjBAbwaCHyPqN3r15d9NeybjF/NajKI?=
 =?us-ascii?Q?4qZRDTrR0j+0IRbZRxDgBXOBYVqzicc+6n/UVYcxrHK1TlPlfDu5MMietY/h?=
 =?us-ascii?Q?UJXa5CB1WuB4SR2i76/H6MhjHKoj0tuWW6ZxGveE6FYbdLqDC19oeqh/GeQ2?=
 =?us-ascii?Q?JtxXcv2WdYAaXXQ3iUaNgtghOA8ho+DainXzPx4qZJtTt5m5SU3KwsD88Ywl?=
 =?us-ascii?Q?VAZX49tP96vcRPPXnxxXiVhGk7urRu71VH1QStP8BOXvX/nbPgIQOv6bHaJJ?=
 =?us-ascii?Q?bEqaaei5R3Rj3oDcfGAtWnjpQlyfBdczzUOH4oP4TdUXtel+USHqBLvmc/mQ?=
 =?us-ascii?Q?FytGsfAMjgFMCFpRlGPkjCdEby1ouWpOcS9oFM8I/LL6CLqB6+FkASH5YQEt?=
 =?us-ascii?Q?mcgyE/8gvoqif4Xp/dMVkVXbE963a+8qqxjkvK8Wc0buJcN/lC0QRLyUtwao?=
 =?us-ascii?Q?TLRWbv+9lbd9FUy/qKr9Db9eNYzR8tZoKhQTp91QL1/cprjOMhd0Tf2huQDe?=
 =?us-ascii?Q?P5FPSkIZL2WZRf0rOJh5eEfXsUvkBw+DIlSvAVWZiCoGTUDHfXC7DuH1o2fl?=
 =?us-ascii?Q?E5uQ7VU/Hx6LutqubD9JMYwU8TH0TPOg0NOMC7vpYXyZ+WpK60NSAozJuGU1?=
 =?us-ascii?Q?rnl2/Dy21yM2kzz6tEzEtwCwBsAypg0SJlzvuz8drRBVmmH8FNedTVjTvszw?=
 =?us-ascii?Q?lC2y9eGvV+RPCuIb+PyfFRAIE2aNvIGM6034/jR451TzAEnRnptPQMjx/Bx2?=
 =?us-ascii?Q?bAsQfEQtq4h33qAFFKuzo1gZK4KMxqZjfTkiJWlc9PFna4XEmoARpF2Vh/r7?=
 =?us-ascii?Q?rwPgNCN1hAw6g5rO3o1yQ8iKufHN8CYFjY8tRDncfTqdElBBTEG/?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7f00cf-6f18-4cb3-0324-08dede5a852a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:09:09.6710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GTyF5D+nS9fT4WEfhLYDnor12Jihc1mxQXr6L1Z4Nkq938l/tU+r0WSYSA+FUfksdOE4TNrciiI8lXgva2mlag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB6374
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,linux.dev,gmail.com,synopsys.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-12269-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:cai.huoqing@linux.dev,m:fancer.lancer@gmail.com,m:Gustavo.Pimentel@synopsys.com,m:devendra.verma@amd.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:fancerlancer@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,valinux.co.jp:from_mime,valinux.co.jp:dkim,valinux.co.jp:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BA228738540

Hi,

This series collects fixes and interrupt-path groundwork for dw-edma,
mostly split out of v1 of the "Support dynamic LL appends" series:

  [PATCH 00/17] dmaengine: dw-edma: Support dynamic LL appends
  https://lore.kernel.org/dmaengine/20260615154111.2174161-1-den@valinux.co.jp/

That series had grown too large to review as one unit. Patches 1-4 are
what remains of v1's patches 01-05, slightly reordered but unchanged
in substance: Frank picked up v1's patch 01 (the residue fix) into
edma_ll v5,

  https://lore.kernel.org/dmaengine/20260709-edma_ll-v5-10-e199053d4300@nxp.com/

so it is no longer carried here. Patches 5-7 are new. None of them
depend on the dynamic-append work, and they are worth having on their
own.

Patches 1-4 are fixes.

- Patch 1 fixes a swapped argument order in the HDMA channel status
  register access (Cc: stable). v1 deferred this to a similar fix
  expected from Devendra, which has not appeared so far. Patch 1
  applies directly to mainline and can be picked independently.
- Patch 2 stops invoking completion callbacks for STOP-terminated
  descriptors.
- Patch 3 fixes vchan descriptor bookkeeping on termination.
- Patch 4 serializes channel state checks in pause/resume/terminate
  (carries Frank's Reviewed-by from the v1 thread).

Patch 5 drops a redundant remove-time pci_free_irq_vectors(): the device
is managed by pcim_enable_device(), so the vectors are released on
device release.

Patch 6 reads the shared DONE/ABORT interrupt status register once per
v0 handler pass. On remote setups every register read is a non-posted
round trip across the PCIe link, so the redundant reads cost real
latency in the hot path.

Patch 7 moves per-channel interrupt handling out of hard IRQ context
into per-channel work items on a dedicated WQ_UNBOUND | WQ_HIGHPRI
workqueue. On SoCs like R-Car S4 the endpoint-side eDMA raises a single
fixed SPI hardwired to CPU0 for all read and write channels; handling
every channel event in that hard IRQ serializes completion processing on
one CPU and turns vc.lock contention into system-wide interrupt latency.

Based on v7.2-rc1 (dmaengine/master).

To maintainers/reviewers:
- Sashiko's pre-existing-issue report on Frank's edma_ll v5 thread
  (lockless pause/resume/terminate_all racing the virt-dma lists,
  https://lore.kernel.org/dmaengine/20260709154606.734B31F00A3A@smtp.kernel.org/)
  is addressed by patch 4 of this series.
- This series textually conflicts with Frank's edma_ll v5 in the v0
  interrupt handler and the termination paths, but the conflicts are
  small. It has been tested with edma_ll v5 applied on top, on an R-Car
  S4 endpoint/host pair, and I am happy to rebase either way if
  preferred.
- The "Support dynamic LL appends" v2 and a follow-up v0 engine
  recovery series will follow shortly. They build on top of this
  series plus whichever revision of Frank's edma_ll lands.

Best regards,
Koichiro


Koichiro Den (7):
  dmaengine: dw-edma: Fix HDMA channel status register access
  dmaengine: dw-edma: Terminate STOP requests without callbacks
  dmaengine: dw-edma: Clean up vchan descriptors on termination
  dmaengine: dw-edma: Serialize channel state checks
  dmaengine: dw-edma-pcie: Drop redundant pci_free_irq_vectors()
  dmaengine: dw-edma: Snapshot the v0 interrupt status once per handler
    pass
  dmaengine: dw-edma: Defer channel IRQ handling to workqueue

 drivers/dma/dw-edma/dw-edma-core.c    | 170 +++++++++++++++++++++++---
 drivers/dma/dw-edma/dw-edma-core.h    |  12 ++
 drivers/dma/dw-edma/dw-edma-pcie.c    |   3 -
 drivers/dma/dw-edma/dw-edma-v0-core.c |  28 ++---
 drivers/dma/dw-edma/dw-hdma-v0-core.c |   2 +-
 5 files changed, 177 insertions(+), 38 deletions(-)

-- 
2.51.0



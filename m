Return-Path: <dmaengine+bounces-8520-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCWoDZIyeGlbowEAu9opvQ
	(envelope-from <dmaengine+bounces-8520-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 04:35:46 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8968F9E9
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 04:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 063BF303FAE8
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 03:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B531A30C61C;
	Tue, 27 Jan 2026 03:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="PbWZiN7g"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021079.outbound.protection.outlook.com [52.101.125.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403F830C616;
	Tue, 27 Jan 2026 03:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769484888; cv=fail; b=V4E+Fzse8bsBh/KRSo7DoCgYOPhK34I/E7YbpGoqeG50GZUHJbN2eQ17uviect38wJUXIZ7hSVoCKyolgXz1Hte2VrcDui5N8hkseu6F3UEji6mCC1GndsWz9el0xqiVWcfwwdbZk1+75rHPhBpwO1Snx4PxPihChC3BxSnSzEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769484888; c=relaxed/simple;
	bh=ZFddtiIljJV8bPqalopfGap5kq/xyBhgA9QFpi+GzAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A41OSNfH1CUOVKYAjd7u7BUVk1Ecsa1heJrF5mR1sy5pEFSi7elxI7Me4aB8UnWAQHf3MqEXz3o+hr5g/FqpsFN/P67QzSHz1bGC+M8evt0FJqtzmud7tC9WIRCqwfNv+8PRdN0u74G7Ya2kt6Fl/jd2GnLn2PbPbJ7U2IJkcjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=PbWZiN7g; arc=fail smtp.client-ip=52.101.125.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+15fx9idzkET5gbkkvB7fveS9FScpApYl4qTHQPUmuE4Xod/U4u/GdAzNDmFF74DzWsthGjSN+yqTtp1SkOzQBPH8vpp2jI7KzZH/xx2UeCzxwt1PaOKb0ZxW02RIxw71ksR0gvzTEoTiJGCdle8AWcy3NL6f3o8nXUW5tLorCjy11/XwXleimeiziiHHwQFEqigUk5I8w+/9DSIymvz/I/Ih4Xq00j5BdNACksQNTzSbzYilQ6x14PxDtfkRR0Q2fDddR39S9RenabxP1gmdpFlNCSuyCkEGtPUMB5O899/Fx1fj33Sx1ChMitaOjg1hwXxGEs3AVy2WCUw0tZzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdygeLCEVrYabW1EEZ3BFK0qUUx6AbRgKmOsoz5Kl4w=;
 b=JWgVHrtTPxiIJJyhznP7aDTe5WOIswJAbBMOQWT9nCaSaZPdUQsEzYdwdl0cJgzjZYtH1oe7QmMzUnvLiyoAVvDVLmFfx8tr5iQhG/ZUmMvWY8E7ROyMGTAO2oICXNEWjKXgskumtlHRgKp5RqfNP/TV+LPcSP4PWoJAQdcU/UGpkgaOvllRJ60UEe4iutj6uJ1jsNSPLxOmuhpcx4rVCSjCKVMujfUmNu3X364UAZfHdd1vFWIRQog8EvhH5QpcoLLQLACSukiojE23rG7lNE8JTI0OWOvqd6z40MvGngYHwKgUg0qtsGB/WDPsEYSBgGHR1k6B+K38RlcpT9W3NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdygeLCEVrYabW1EEZ3BFK0qUUx6AbRgKmOsoz5Kl4w=;
 b=PbWZiN7gObmqfesoA1RWgYRa0QBptUxWxx91UCYuXw0/7e43fHVC4qSknJsvwQBThNIlvCmugVs010ViCgUe2Cix56wPCj27uNUQrdyB+93pfXtdYLAY6zYc3rGpWdm39apjOagCKgfMPEufH6X3gWF++0O0gkh2RkFEL/ZkZZE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSCP286MB5626.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:3c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 03:34:42 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 03:34:42 +0000
From: Koichiro Den <den@valinux.co.jp>
To: vkoul@kernel.org,
	mani@kernel.org,
	Frank.Li@nxp.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com
Cc: dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] dmaengine: dw-edma: Report channel hw_id in dma_slave_caps
Date: Tue, 27 Jan 2026 12:34:15 +0900
Message-ID: <20260127033420.3460579-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127033420.3460579-1-den@valinux.co.jp>
References: <20260127033420.3460579-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0246.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSCP286MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: be30efe3-d407-4c33-8281-08de5d5501f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kDwD013bpliTfkp+a+up5rFmrdsNb+i+AxQHfgoS27Duui7yb7rki7g8cQoj?=
 =?us-ascii?Q?Jva1yfMd20NOw4nSuG9K7bh1zeaqhi/tePKvgV/jA/m+VtQ8rNU9BBzXSdSn?=
 =?us-ascii?Q?FOZTdg69Vr1yL5AMOBonukZSXj1t5rWNwjaFeevqtMFcP23dylhcZtopZ8eR?=
 =?us-ascii?Q?ezdYii4aSAc/wMPFsEEzKe98gBvgVpG5Sf1VFRmV70QCwJgQQdRjv8rbDTSF?=
 =?us-ascii?Q?6kuzHCiFgEiqUQW23yf1bMFjfsAEDRLgU+8dUCkionhrnbcncCnZg2wMTZR0?=
 =?us-ascii?Q?qs9+QJFCvCEKDyYEdkkBkaCF74JTuWLKSjoTzHHyDJzLwbAmzyJa9+3sxzv4?=
 =?us-ascii?Q?jgG3OvWJIm5nbuuDZsLPIymnnVsveNqi6ZJUm6JNOzAmUOTh3s8Z50rN1lNP?=
 =?us-ascii?Q?z222Gs2qm2n+Ymxhr0dhuvoCIlCtCksr4cUqTHmxq3VZJhRW/hXuOPec+01N?=
 =?us-ascii?Q?VmmnaIhHwTMVt4EWzuUhUe2FwWh0r6rT+k7BOhgL9qqdfMgrCWwZtMOHKq+3?=
 =?us-ascii?Q?j7M45bbKKcmU5Eb6OkSAi2QsCl8kprKDKB18/Mp9LNxvroGua660wm5ULW6s?=
 =?us-ascii?Q?9rHpLwcHMgELUuruOI0Iv0AhUNVA8D7I36xR7cdSYnhzeeBhUJDfLh157486?=
 =?us-ascii?Q?XNr13r0nbKHT8JKLqqf4L9PF2u+cCNtsodWBdyL3u51b/rSXxWjX95bkOvjm?=
 =?us-ascii?Q?MeKjl8+FY+cxIetwD8iDfFsOE0l+tr7WRV+UUBIb14ikVx7Cy5fx/pYSPrHF?=
 =?us-ascii?Q?9P0t8EGOEj7sHE19cBC1vavjy9c3wh5U074MttMFN+W1Lf2aUa3HRqyIw2+r?=
 =?us-ascii?Q?Rug5dtE8Z/dDtMqANvRtaM/yIT/aZrLQ8trP6mq/f6I2hW3ekQS+PrC3mm34?=
 =?us-ascii?Q?685RMwyZ3KXLZbgKz0VdAQehreNukME0ECiZTwZIHVdsjC82HxF3rko+frgq?=
 =?us-ascii?Q?vsGuqImYxoMxzydl6BLK1mIYCUGzQK/m3GtN8W663yDaNF4LEd2yJCYFfZYd?=
 =?us-ascii?Q?y8hlGiaa7OSQkVBaPFCBNSciwnqE2u1lr9Tlvit98GQ9LMkyFgpDv08BA/Bp?=
 =?us-ascii?Q?lNXl5n2Coi/pfN6UEHxjFKwkao1snTHlRD1ZC9ZIuoVQN8i3LEBAQT6t+rBq?=
 =?us-ascii?Q?duHWvDlyor9ga31wg1nYsVwGUy6n+YAB8eAQzYrFZIxt+/bewv7ynA6pPBLq?=
 =?us-ascii?Q?5DAfbUmtEUrYYOPqCUN2Tyun4gjYEgLNfiYtVQyutK3a4sZppstAGEG1VG+3?=
 =?us-ascii?Q?bbGpCkHq+tZQ8l59My2O2mMeUKVCwe+pdrszxtCBvoIgI+RoiCqLMOTLHIbN?=
 =?us-ascii?Q?K626mY7HFDCEYaE7+fAK3fpxFTrx/AmMTP1+bjpNdnBHSp+cAQvJfTU73XeB?=
 =?us-ascii?Q?0kw4lDdxIbjD78W3Gt5z5H01YDOOr4h5gX24ZEZvU1ebq8VS7t9wqyaIjWJ2?=
 =?us-ascii?Q?So4IUo/lP2EgI4c44Ae8Q2A4U83028Js2hp40YJb3HoyU0h7B32OpoBNQ6c1?=
 =?us-ascii?Q?43q7rI7H8IeaRjfjnS2LRWe1+zkTB+d2iW9/lKx2CkCIWnRCZ5GeNBn1myiK?=
 =?us-ascii?Q?nJv47wqJHPqi11eE4Hg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ym+uYHRp5ACUdCzDAsUeDjLNEg2IB5StIFQ1wO5VyPkRbdUgslJQvywx7E0W?=
 =?us-ascii?Q?EsgBx3rVSnVnmM5mfXu5u2j+IvGFX7m30jAMR908XjpJKvErlVOixNDIlYBN?=
 =?us-ascii?Q?PTmR8XNAN32QE/ecwI8aXjRAuUwF7HwddWKHvH4hpdkf/u+s9rOab59dQgld?=
 =?us-ascii?Q?Q5oc3Z8tPP44oSbtg3FtpXg1DSHZk+p85+VGrftalWXLuH8tr//T0PV60nkQ?=
 =?us-ascii?Q?DwmODyoKsU07spUL0H8FdIgHL3edmAtHyR1d/gITUjAmszvHJu8+fdl/QMqw?=
 =?us-ascii?Q?gZ4H34ej7IX44upT4KbpQoqDC1/BmvKiXHjxvP1AVKZa3iXLWZNRNuqEqzwg?=
 =?us-ascii?Q?EWyWcmLbcST5+2YiRqmCQ82RIp9qTUoUbftwQddzZ9HHsvvG6PDYb1NK989w?=
 =?us-ascii?Q?lWZWp62ydrqlgnkoKmZ3363hJDMK3/wnAGVxWdiogfI21LMm1g4N18uGK/lu?=
 =?us-ascii?Q?GMwsKSJoMPG38gmwLZjEP1aMtVkcZ8qIp0uqTQKfVrfaasfDoB9o/kAAX2rx?=
 =?us-ascii?Q?mmpsvOzhUpX6Rz6U5bu3tJvN8nT5fnMUOKTY5FYejhTa1NNnEBjlJmD64CMA?=
 =?us-ascii?Q?5ddUnbnqpu6X+NY3qHqilffVBtby+cduSZdGfZ7WrobjpBHsoAuPxHX/yQCV?=
 =?us-ascii?Q?2wDmbRJrWnI5C9/377r89E5kf21atX+BmoUmG5wkPpnWc1x5e4Jt+W/vVC7I?=
 =?us-ascii?Q?g5lXcgQdoqr1X8HdvSOmuGIbGwGlkz+tS+huyAvWWdvZWZwDPQ0EsASPSBV6?=
 =?us-ascii?Q?JZ11lk1yBUkhlpBFAhnF6wNKx4a8t4r8AmNTx+mygvFKxXEHtIK1slL4v8/g?=
 =?us-ascii?Q?8/9LB8cN4Y47uSIw5wC2+P7dECt+RQ4qWyhXYpnU4ayex3bQmdzn5w2NFyQ1?=
 =?us-ascii?Q?cWUSLY1KFa8FNEVmXyONnAnbHtWPSIvYSskpXQ5v8dEDGlVsMvbCrpIxhCjt?=
 =?us-ascii?Q?LpJ7H7Ofup5NtqdNQ4g7VMLcIdnXCzMPxCQfRL00SDmrD+Ds213GUecyx8Q9?=
 =?us-ascii?Q?v71tTeBywbIdsVcnveSjkNs/eg7preBOmuXydBPABYhZMD5GQ4let5KVaJP8?=
 =?us-ascii?Q?ltrXoJY0RiMfi1TM/8R5K5tEJdt2iCc3Gk6/psWbloYcxFARU4RfPbdBhD/n?=
 =?us-ascii?Q?yXL8CnXnBdaYp49Tuf3xbHCelNYRBhzi1d9bMbmWWDzl+7sMa6wKAUC6/mI2?=
 =?us-ascii?Q?ni/r14qij6i6aRP3hTHMFWuXixFiotYzatrGThbcVGKPieY89S88wps69UhA?=
 =?us-ascii?Q?47/Y0vtaLqHVlX2tHVB8ylHBj8eAD3ehLs6KFNhy5noGrZBb6FBwFz/JpqcW?=
 =?us-ascii?Q?okun3ah5IFq6JyS7Uvoyj+LiIlrXCbkqK2sy6mqRXAvZ3MQsgtFEw7tSwal5?=
 =?us-ascii?Q?EMij5yshw3/DqFonTMDH9zwZnhLco8MEDc/AmsRZAogjwx/C1mLaafQFN+L0?=
 =?us-ascii?Q?8oof8INOBlGbXtyzNekl+/UHc7C1PLh+HMTdakquXrcVuTNfe0roXe3K6pG9?=
 =?us-ascii?Q?nyjXPTZRjcw3Egl3CPXDVT45zTzWh+mfRmLWP6TTkL+/biMjlA6+ozzEJMHW?=
 =?us-ascii?Q?86WWN3PAZvxw0rT8AqsfkqwYsVARj70gqU5W2WfCDRuGtGpS5+WPYqNAz9jD?=
 =?us-ascii?Q?2g65F7gyFEasRF3bFcmsv++AoS/BDaaiaOBrXjF9V+r9627AC2WQPstcydG2?=
 =?us-ascii?Q?vDL+f0ApxBujgx1wOA9NoRRX0u7o2oqhUV743G6y3XAh2P9sZHy+ttwtpRq8?=
 =?us-ascii?Q?HKbVswlEi0U7xBNMcEpgXnWKsxy58pgtBe00fNWE+Z0kqZvXZXoS?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: be30efe3-d407-4c33-8281-08de5d5501f2
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 03:34:41.9995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/kLCkUWVugNN0/cjFMwFAkvjdrbsq1iIx5bJicvUa6RhaGUh7c2ftebs0UGEu1VmDTx/5YISePksxJtlnZ9GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5626
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-8520-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,gmail.com,google.com];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,valinux.co.jp:dkim,valinux.co.jp:mid]
X-Rspamd-Queue-Id: BC8968F9E9
X-Rspamd-Action: no action

Expose the DesignWare eDMA per-channel identifier (chan->id) via
dma_get_slave_caps(). Note that the id space is separated for each read
or write channels.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 8e5f7defa6b6..38832d9447fd 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -217,6 +217,7 @@ static void dw_edma_device_caps(struct dma_chan *dchan,
 		else
 			caps->directions = BIT(DMA_MEM_TO_DEV);
 	}
+	caps->hw_id = chan->id;
 }
 
 static int dw_edma_device_config(struct dma_chan *dchan,
-- 
2.51.0



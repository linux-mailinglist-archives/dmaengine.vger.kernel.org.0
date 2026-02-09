Return-Path: <dmaengine+bounces-8846-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGWiCuLYiWlUCQAAu9opvQ
	(envelope-from <dmaengine+bounces-8846-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 13:53:54 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3F710F2A2
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 13:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD281302428E
	for <lists+dmaengine@lfdr.de>; Mon,  9 Feb 2026 12:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC1337882A;
	Mon,  9 Feb 2026 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="aVJc/7/T"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020117.outbound.protection.outlook.com [52.101.228.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8837D3783D3;
	Mon,  9 Feb 2026 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770641605; cv=fail; b=twdw9wEF7lr4ATcsrWcw8lNIHsaP6qy0aj6hPNvlYirKqn/5gK2rgBzRjIehIOamX5/slc88BVMAqOtvowV0+Kbj7sar88YflXF9XqCXeqU23bxB9zDQKEONpJNmvqcafBIaJredjaq+rDrPzOnrGm4sYP8WdB0XF46w3zafVqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770641605; c=relaxed/simple;
	bh=07NOOa0/rNNL1PxwvNlV+aogVqz5aF0BbgQCjbNwprY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RYJo+4aiE+S60N5hrBqzOCDPefEyioEYA9igXsosj1gPZs5wMItk5kXgpQqdWGRqqySbYM6DSaO7Dvvjj5+N7HHBn2V2f/QuSyvKMYw5xCW4w/8Gm71B4ojcUeeIYutkNfm0obPg2VDJVbTTKUiW2TgQEtPdokpre2n5TFipux8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=aVJc/7/T; arc=fail smtp.client-ip=52.101.228.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+ygUHm2Zi/HOu9n6ptlulSCrqr1beoEiHDfiS/lL9cbSxtg8L9W4N4mbGbySzsToWXOD9Mhpe38TmmD8gRwzwRNv1kdD7b7eXzTAsJ9xsH9u6go2Y1bQn4k4mYlzdX4NBXXJC829gi4m63Nbc9kEANlv/OC9KICsUrDPoaNMtImj9AK0w1PdofF6TKFaf487w35JGnAqjflc6POE434HqKuTNiREnYGsjvavNuDKBMoeBvXZGTKOHEd5rvI2nUZ4nDSHM2cafn5rYNsmOERnXapw4UaZxfKDtK45/s+SYYk4GcYU2FS6yIURQTO2Cldszpj0h0vje+og+biaOnWdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmZ6hbpugReJK6Dpis4ijSWWldbK6J+3kcRgGdadZm4=;
 b=tdMP8SUidz2QLYBFXN3E7MI5IDfrONNqsJbRexqtwqJKVjWOqXUuNQ4XX0aGFGbZXPH6NI6AHyiIte/3d2b0xfUZA30ztuq3/tNZUEK+8nmSWS+vrbcXDvpm1uf0GV+2mC/9GHSHL62Fyar2nMz5DynscexZWbj9WfRS++PWjILwLzB3YuDKTNLvnWMduK6XbMiPN+E75ArNWEuMATSBMiGuBrwJjxcRkzQ+aXoKcFNybmMGqAUc0nwAYw27k6+W/ZZSZe/oFoS5fiIPJKC6OIgXlFV4spk3dU6xmo73CEhQafU6DTh1M06cvMHTgCP/mA8gJOHHh2SHj9U0uUky3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmZ6hbpugReJK6Dpis4ijSWWldbK6J+3kcRgGdadZm4=;
 b=aVJc/7/TQdugzOuuqDIuD/DAA6jCFaDQarD4Cd1iUryKXVxsQXU7vZ/DaZTmbadNuQIFSX2KIDnDwwrTuNPbSyOeuy7XX46I+Fjm1Lsc75s9OWdbHv7mukdzY87adtqhG41A9ggcmVUMFF/kxH0bBQkkyQ4/SuvN9uZDARsytnk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB3742.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:237::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 12:53:24 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 12:53:24 +0000
From: Koichiro Den <den@valinux.co.jp>
To: vkoul@kernel.org,
	mani@kernel.org,
	Frank.Li@nxp.com,
	cassel@kernel.org,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	kishon@kernel.org,
	jdmason@kudzu.us,
	allenbh@gmail.com
Cc: dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 7/8] PCI: endpoint: pci-ep-msi: Fix error unwind and prevent double alloc
Date: Mon,  9 Feb 2026 21:53:15 +0900
Message-ID: <20260209125316.2132589-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209125316.2132589-1-den@valinux.co.jp>
References: <20260209125316.2132589-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0082.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB3742:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c966a81-fc75-40ec-97e9-08de67da3648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v7dznlfjP6x9zPBBvj8L0JUpK3xLyxl54RVXjo9o6WSnrimLxId7XpzgwufE?=
 =?us-ascii?Q?ibljWQWQPjng6cZE0RAwNW5jPPjIsaj/m9eVNK1bLxsMcBSmArup+s/rHuj3?=
 =?us-ascii?Q?i3jVjRZ8Nci3bwrqoe9gma49OIsyQZKOeRrJNob3QgM8jCEROtusYUoE4eN7?=
 =?us-ascii?Q?P0SkC+6vB/9kJeEsBF+Qxrt7d9j0qT62KuaMl7QDVx0fFR/lhudgoC/OqyCe?=
 =?us-ascii?Q?eGKPHUY7ifjl7iaiiXk1s2mhab6sJ+S8mRvkO28A2T6HtfJGCnuGYRtq67kx?=
 =?us-ascii?Q?ZmZhg0R73pvOR531//mQJSE789Vqj6paEoyXm0HEOU2t/2r0piWvMRkNNyRp?=
 =?us-ascii?Q?qSXuvD+gKrib+qVCqIvUb+274qEBZZrKFPRaD8RitmKRNNwxc/pPQzs6mXYM?=
 =?us-ascii?Q?+ZusYU74N3GE+7qrO45+c4f3KK99T2WB/g7ER1QqXMRRSCDqtuY+849MynDo?=
 =?us-ascii?Q?Mvpc25kceNrioUS5im934mAMCkf6UfIMwcgVTcMIkhtOPPqfQbvqbizorqdN?=
 =?us-ascii?Q?1twtjZbrol2hyrAPYcVtVIMyFDjObehhm4qtFJu6/2vb97YbDIcDtCDKitP/?=
 =?us-ascii?Q?jMypkmjRLIF9/PM6VbgK9kNVfFRVm9uFPIpIHHlgUhuyJ1+MzrKl4VGGHw8v?=
 =?us-ascii?Q?YtzuYGPaQ4GAo42kb6RRa7Jre/QExahD7DhHkDOkeme3Lno3KUKXkpKrYv3d?=
 =?us-ascii?Q?GL3FnPj0a5P0LE1VqKOpgtgUB6itvbLrGYPY7HSRgg78Xm7C+q/F5N9ytaU8?=
 =?us-ascii?Q?x52Y1ZyhuYQV1WvFh2RFD3blFp3xzjju+0OpFvvIx7+QZ8eyR5WjwolA9uKH?=
 =?us-ascii?Q?sm03wpM1YOQ+kCQW18NB7yADVxrcZgDATJQwP/OGAXhaGLbpchpNik01Kjsi?=
 =?us-ascii?Q?GbYbtnhlXRLXgAsWyJV3IdfjpZIE0bYRsvYti+pXV68Py6LUJX1PU5/Dlmuf?=
 =?us-ascii?Q?k5rZYfjTaM6oQXOSQ31mybFzvM1MPDucSbAkqNl0wHmBbyQ2vYC7dlOWmHJu?=
 =?us-ascii?Q?rq8IGM6K/yM4NEP2weN3A8cysYjvD4yP5g9iOQojiwcXkNDpNuGQuqLeYK4S?=
 =?us-ascii?Q?EfJijcOMK2VE1kQCE9yak9mfsTsnghpvG4fBT1nusDL+tKiFgOxR9F82SzJj?=
 =?us-ascii?Q?hNZBaTKw/s5Qtl3HSc9f/qIoSa1sl9KoEAIH9u5fablzjZoy22Y6YfZFKSeg?=
 =?us-ascii?Q?RidZZF7J9lD/orfLs2gwPevDZ+rrQ37aiOOKl4KqxwuAyL32fGVsKsjtY0q4?=
 =?us-ascii?Q?Fb4WnK3QgybE7ADKTobA4q2j29eSB3yMGGJL8z/hWnnHFhC45d0ilKLzwnLL?=
 =?us-ascii?Q?SbqNvzuEChWscDKYdnocqfo/Sltj6Yr+3Y8SHJByIeEx48N2yDggGyVoBkbS?=
 =?us-ascii?Q?rqq7vNy3FAAKdWxnf3ahBJVXVOiHk80Xd1ZDx3eIHvGwu/mFd9h/EhyVaUev?=
 =?us-ascii?Q?3YMpk2dag5+lC+qPGeC0zFTT/aOJqP6xz+4ZY5TBADCg1a9JSLdRvV+ZWfI1?=
 =?us-ascii?Q?uvQMIQFA/PYUBZrlyNCL9fTgRxKG+RusuKgf6/6ckfJx65eOr2fJdkczig6R?=
 =?us-ascii?Q?a1zDJ2vjckt0adlD10Zz3Gihfolk/CJ/62yD0pXMIzp3Np7QIFQqKVWVtrxz?=
 =?us-ascii?Q?+A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RJTHV60Z/TlB+K+8vJKH7l22aS/DH+pGHOkZKca6afbbyxgA5x6lpWeRkSTh?=
 =?us-ascii?Q?MBZ6TgpVMRNfo3Adr5U4fYSGwtPkxQK77DwgUbzjvIWz7nzjcaZC5y6gN2N1?=
 =?us-ascii?Q?Tbjmv0XBdLNLcf77Z7it2hhoiUUB8l5wEEsBFDM3GevvBvcfACsNWkFkR83X?=
 =?us-ascii?Q?YLUSKT0tm5BkeKwY15kBsP2NP3nPfT7ZNMeqByf5IXPyq9AVxuE1boIcu45L?=
 =?us-ascii?Q?FKdD5ZP4FoLlAZLLz4qToJ7SVsZPT7Kb3QGPoEiAAewp8oWeS1gOKW5HRh0s?=
 =?us-ascii?Q?mx+hRy5Jmtn/s4eQL+RVpNS8vL8melAiK/fCAwHwswNbdVKfnTsmpvKNRgmd?=
 =?us-ascii?Q?YPL7J7igjZ0Z4OCOMSK0Dj89lvBuHBB5vct96KfQAlBnN9Z0wryCgflHur2j?=
 =?us-ascii?Q?UZuG3PzkMxg5R5bYS6wBxg2q/D+OM+sgRvmmcd9TVFQnJxxNgzXZcESUzZdT?=
 =?us-ascii?Q?UvIQyf7YA5Qy8UdSFrzgdB124HdlF8KtODiXpw6cmwigP63KQUmOoykFlP0G?=
 =?us-ascii?Q?Dqh7D3LBf9e6r1KMQ0Ma39h8cSrWpwIToPkHvSXqxliGK6dyDwD6FTl2AGC1?=
 =?us-ascii?Q?ZttfZGIRzLMXaeHUyftTqxmIxURydgam80lKI2VliAWA2oQbmXHfyhccI3Lh?=
 =?us-ascii?Q?6UhaEyqBrwp39aSzUe0BZdIxBXbufrjr6Z9ivpkWOsCZ+lkFoyCRgTZsMTSf?=
 =?us-ascii?Q?+fFN3cEd8jBj4nTziHpZ8v7TFES/nACK/zV9MNjV81RZgZ822FOx1olI4GNB?=
 =?us-ascii?Q?zifgQoZJelbxkZ+ybZdXyzYvzHNg1RJH5G95pZlfxC/KA1GUobf8sF8RXbwx?=
 =?us-ascii?Q?kws9hcA8MBMJQn6998S6MsbD7d2fdTUPFyZx40IprY7wKmu+481Sl0zp/KhS?=
 =?us-ascii?Q?DNcWALd+qvcI9RVJGwnBPIf0sLYlKfjMFFZw70B0NjQ3gpIyDnHXqSgrgJyS?=
 =?us-ascii?Q?BgnEZZw6nGKiQUb/dVqfTLo/Zn8m11yPSMiRn2lnSyyOjhi+sUUZgZR+1bIG?=
 =?us-ascii?Q?VYZFJmJGGKqApSB+PXP0bmb8vhu6fq8hPHeCG/KRrmBEoOKZ675m6fJ/QKv3?=
 =?us-ascii?Q?QsMRjmwXuL/GxjUbEIFlEThbjaBx0JLQMbRJ8vM6c3aMr6no40BADBJYUf96?=
 =?us-ascii?Q?4ohY43Iuqh8j4avP5GFZSiZCh7bbbxgSrpu4M0CL4cR3W16+ofkrm+b2cyvr?=
 =?us-ascii?Q?TJgUb7cqTn5vneE2Ss9UfBksI/4/qXhLKWt6l4LYnU28DGD8qXnT08fpmF/W?=
 =?us-ascii?Q?f4V+mSsRICcAEAmvRrftdhB2QU3pKxtG5pFTtGwMCsJ3kfv7AjC6giDORx+h?=
 =?us-ascii?Q?vWIoIkM+OpWHzP6AruypSWZm3OAvGCLZVgQXSuS5XL2eP24M4a/HQyEQqDLR?=
 =?us-ascii?Q?r4IRN2ikNiV1jI/IRjYo3gJal6a+E/mZWqgiFFy08N9ZiPNP/uKunxAuOxGh?=
 =?us-ascii?Q?gFMAirzWY4X2UwdDo8KKaJHXCuPXEBXkRn+CQdn1I4u01f55RIsrIebW0eVI?=
 =?us-ascii?Q?PfpWspVIEm5W4y73xs80XvASOm0sHNTMBRf2I0UdMP63R6YLh9NJDHtdVD+9?=
 =?us-ascii?Q?Qpv26yd6jU/4rYp37DtwD0wObLjoCkgbmjEtJ4q7kGAPkWW4Oieun5PGqvoj?=
 =?us-ascii?Q?QB671EloepsqVGh3XqYPb7PHHr1eBT9JfUOC8sJbApnpLjiD7jjAKxd2S8qN?=
 =?us-ascii?Q?jKjiR6gLbPg3PX3i2CJ8mRKdYy/1LUXL0Wyw6fdpIynNA5lePn5GYyPEeVB3?=
 =?us-ascii?Q?GdA5opX0bj72u6ClrJLbgxhb4wYcd97yvYmc3zoXjYIzwMuk48/a?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c966a81-fc75-40ec-97e9-08de67da3648
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 12:53:24.5117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35+Q3LL51Sq/c4+DFZ1rIVnx8oVtNXX6U8KRZX7g6bw3z0vFDNsjjwqr0IIv+0DwcYbDvRP6ATNNnhrw5xPi3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB3742
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8846-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,gmail.com,google.com,kudzu.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9D3F710F2A2
X-Rspamd-Action: no action

pci_epf_alloc_doorbell() stores the allocated doorbell message array in
epf->db_msg/epf->num_db before requesting MSI vectors. If MSI allocation
fails, the array is freed but the EPF state may still point to freed
memory.

Clear epf->db_msg and epf->num_db on the MSI allocation failure path so
that later cleanup cannot double-free the array and callers can retry
allocation.

Also return -EBUSY when doorbells have already been allocated to prevent
leaking or overwriting an existing allocation.

Fixes: 1c3b002c6bf6 ("PCI: endpoint: Add RC-to-EP doorbell support using platform MSI controller")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/pci-ep-msi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
index 1b58357b905f..ad8a81d6ad77 100644
--- a/drivers/pci/endpoint/pci-ep-msi.c
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -50,6 +50,9 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
 		return -EINVAL;
 	}
 
+	if (epf->db_msg)
+		return -EBUSY;
+
 	domain = of_msi_map_get_device_domain(epc->dev.parent, 0,
 					      DOMAIN_BUS_PLATFORM_MSI);
 	if (!domain) {
@@ -79,6 +82,8 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
 	if (ret) {
 		dev_err(dev, "Failed to allocate MSI\n");
 		kfree(msg);
+		epf->db_msg = NULL;
+		epf->num_db = 0;
 		return ret;
 	}
 
-- 
2.51.0



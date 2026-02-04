Return-Path: <dmaengine+bounces-8739-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJM1JD2Hg2niowMAu9opvQ
	(envelope-from <dmaengine+bounces-8739-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 18:51:57 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A0DEB383
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 18:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FC1C3087DC2
	for <lists+dmaengine@lfdr.de>; Wed,  4 Feb 2026 17:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C9B3D1CA1;
	Wed,  4 Feb 2026 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PfCl0d0N"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011046.outbound.protection.outlook.com [40.107.130.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53343B52E4;
	Wed,  4 Feb 2026 17:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770227207; cv=fail; b=FDAL7JCDtWy2xXwQJwEEA8i1A/r7oOXRFA+8emh8L3IvCB6npQhtAV0BU7jNVGOnit1ejrJJNMf8cVVMvPhLF4cbs5vp5Qek6fJwba5wR1Dv8TMy/8XkkMJ/FoScFWJNasnqD/m9MRk4Wwt6MhibODgtTQkwtNUN0y6CvrNhnyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770227207; c=relaxed/simple;
	bh=31GA2hsQzhLl46dv7C91O2hT+kLe8HDUAQhFeKWS74I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T2VIU0xCELak4rUOLVp0ZbQOA1XMmCvpcuZi67jLzNsT5i8lzmoLHER2qtocb0TrlPSUuDoWSZYblgCQyJdx/BA8qTyiW/2diMvXxZfgWomosNVwIle7PHlzclud1efv6HbqhvZbmfVvL2mAmcT/gtdXegHF2zGkY8bqU5zEOrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PfCl0d0N; arc=fail smtp.client-ip=40.107.130.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzQ3vMnPh5FnIJqscuZDJ67to1DaUvi9vu0xneflMbXziYmttO+ZDgp3OOAjcJXKPumHzPQxRmSzdSvt8J1PjN6dnIe6b6ur2wm6SQhZkqQch11R/UmeFpXyG7P+fh05hKF9ImnngJHEBUWt3HUjy1j+q0D2JnSFUWPtDIiuLrprPLwOO41hlQ6EUpciMaE07s5dCDUOyL2pRu9fkiU5K4Oo6ibPSTVn7svdbLUST9wtz2LyqPssJElr4zr/TCB7t8q3ke4yfn/cuhzgy4gViI5whbRtdpnhUoPNaH+i4UX7hwDWgMk6jyyBQgdERdZWcuTwz8ND/nXflHgobQ2SGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWAqK2Hu9iITHR4sRh2X4v/rjeOeaxaDM1RK5EmTIGg=;
 b=btHSMJzCvKoSTj5JwxMGAWQVPRZbu622Fd35D2V1+7fiCX1uGj+Aoj6B9fXGWL6HhNl16fTgqXSt/JrSXZkiLOeiveUQ741/Zqw3ssHOSFhVFOfFmA0vLU3dHfUNu6FCyUTPnQoZn3M+fumfUHPB6lONigHhgotZLRhqJwCHIsu76Lshh3CNAflz8KytWtnl1ufSpHCKZqQzHXs4mbzJ38mj1IINua/O6vEnRal5eAF3v3AiJkpUUsLi+XoAt5rIiH03kkudyx1EJCVSWNhjPbTPx35UphBFRQrAy5DzWmBZ8UscqBoZh24pA+zrymkqUueY8TO9yg1e+pJsftjX4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWAqK2Hu9iITHR4sRh2X4v/rjeOeaxaDM1RK5EmTIGg=;
 b=PfCl0d0N9tsFzkJXJtrwt9WUt4BVzNunIs4WAGUPVT0R0DhLNGhJbcvnIeTniEBXtiidvaFsmXBSW+M7ZLn841mfP8b5Zqo7AAeLVB+NhjOI46QJAM/wI+5Izs/wCBICjEPCh951hLZ6umDna8uCxPuhIbZZlTCi5pyoD85SaCZ+SJpQYUXE8HPRI2V5+sN1l03toDAzgF0TaRlEf8eXhn+cN4cMBp+G2Rt8Hxe4ZK4++QuWzD9ENsi1ddnMrjmLhtO6rr4OgLt27NNVogUx58rIzRyaM7asp0Djc0xMGf8ZZT9unYMnkGvQ7iJzzXDhwf4VvinjRj8VLkpGbBMNnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU4PR04MB11340.eurprd04.prod.outlook.com (2603:10a6:10:5d2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 17:46:44 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 17:46:44 +0000
Date: Wed, 4 Feb 2026 12:46:36 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: vkoul@kernel.org, mani@kernel.org, jingoohan1@gmail.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/11] dmaengine: Add selfirq callback registration API
Message-ID: <aYOF_JNYZF9IFUCr@lizhi-Precision-Tower-5810>
References: <20260204145440.950609-1-den@valinux.co.jp>
 <20260204145440.950609-5-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204145440.950609-5-den@valinux.co.jp>
X-ClientProxiedBy: PH8PR15CA0019.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::21) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU4PR04MB11340:EE_
X-MS-Office365-Filtering-Correlation-Id: 0be6e5d0-0c90-4b1c-a753-08de64155c68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|52116014|376014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IVmkYzDybz1YmG6/TDLUzl8vUXL0Q/bysTXZ8gXe3wHWPKvxRuQ5IjObuXA5?=
 =?us-ascii?Q?EvIPfA1BRvjVOfcrStaJrP8bHnad5W7XLkuCOd1msbxWiJhDSiAPzRSDAqyU?=
 =?us-ascii?Q?Kozv2gqGBG1FferdmRjHrYIfk1bj1U/TEN5ZBLg9VnY66q5Px+tb6fhkt5OP?=
 =?us-ascii?Q?ojD5iMQ0vtfTRdhi8Wew7OGdH4e1sbW2ylAGOw8dZIS032vuIgl5c/+LibgY?=
 =?us-ascii?Q?4p5XzT7IinLFVf3L8CT+fnMikMdXWmVSTpTPu+omjdGwBZMg4dd/Sxlfqk6U?=
 =?us-ascii?Q?KWlHnMp3WWuqRGCL+BQgYgy6PaAvqRsjOfHagKNdAHcfg1GD4THGjJ/l16SI?=
 =?us-ascii?Q?5kZcnvVkHl/hHwfY0f6MZbU/P6cGfps0B7wkABhceRryXtR5Yqaac5+RBG1k?=
 =?us-ascii?Q?968RLBr16y9IBkBC+m+2WPp5M4LsHxfX1xAvBUH9JS748YZh/B24rRZexnFs?=
 =?us-ascii?Q?Tqk+y+ZBOCUuZiVCkxKGdtgf/GOv654wI4NnY7kv6BUqK+3DMounfdy5KE1o?=
 =?us-ascii?Q?sgbTG8ggDyF/qb6UJL9uOGb80M/dG4lRlc7V7lQqGVLpe4OxPR0nE7s63aap?=
 =?us-ascii?Q?+v6HbyONjKHMNxeO5hpal0pP91roDElNxMvj/b+9onGpbbw92s4RGW7IAJJT?=
 =?us-ascii?Q?B5BlUTMVwKOGMEEPPEgWcjvOuGvsRdNp0AjCkV3anBeiAr0cj7PTH+lPrArR?=
 =?us-ascii?Q?x8Z5G5+A/di7mDPPIgmGSs/r264bFx6N4uP3oUNDVTnAInHfPuoDN3Qw2Qo0?=
 =?us-ascii?Q?NtPGaaPg1AVIso9Z86xlkgu7rcFv14WwHFll5DtgVzh5h2xBxpo/F5yog/Gv?=
 =?us-ascii?Q?jH4rRVArnTR3atmMD6GDfJR/s/ngcMNxTOztbeGlETSmvzQijrsOPb7nUv0M?=
 =?us-ascii?Q?w3t++K9OZRkHAPdqjxB40bT9Zmq+rw4VyD9shofYZjJzGsJm3trmpShMUL/l?=
 =?us-ascii?Q?j1Wqq5wOu3MrtP8S6rWZqUZDdhA0pjJxmRmPalEIsVKZpYDuKhfYA5JgAnwY?=
 =?us-ascii?Q?0NRV6T+7dqwq8V0bdslkGM+PzgXRz7D2uvaY/KjbTh+SLum4BByWEXbeaMuX?=
 =?us-ascii?Q?vJO57MEt7vghkLFcTCy5rf0BLu1CAPBEFBNk9FXJcXS47DSl4gd/AOfJSi75?=
 =?us-ascii?Q?bpA6Tr9A3Uukbk33ROwRXU8Pzx4vzy9OmaSr4HpuGOoK18ChhHQIk0xeX4Lv?=
 =?us-ascii?Q?li2ZRsrh7TSYzZU8CcpdEg0NwM4m4hB+Xsg3RWGkCMwk6AenXsBA51h4s6f2?=
 =?us-ascii?Q?kNxhr5PPFcOHSEB/SyssvBUs7uGA5It8RBZPaitUMw5xwtbq+7Scx8wyudpv?=
 =?us-ascii?Q?z3/0QlakVXUSVATgIHLFgWzs8jlD8/Yld4rBB+w0bjLcJsOzYorR/559EqC8?=
 =?us-ascii?Q?y051P6q4fS+ZvUXEwn9UesgZrjC9KKmIi5NFOrpur2qhf8K3ymkA4rPsP/uN?=
 =?us-ascii?Q?Odl6bBdLIO+BA0ZVseIMcoSmIVPNjk04RS0YpQM0JeBdIhdLMbGEW05cky04?=
 =?us-ascii?Q?b0VJAdsIjmKj/EY0F6lvZJmZArAOQ9q8rPenZLzlz75cH+SG0gioFvSSrys1?=
 =?us-ascii?Q?5700jZGQ+8f3JZr0rED3udpkX3/068uLtU/cstAtsE6SKmjFZZvuBn6kFaaa?=
 =?us-ascii?Q?3z/S4MDwVemAWj33374+/g8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(52116014)(376014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CcSPkR1Ve1dwdQ+vE0EvB5knDJFxMJ22mgQY3TjgqW12ZyoR1LNANXOvvrb5?=
 =?us-ascii?Q?xqjD24Ia7WMON0Vq7naSQU6wgvn3Gw+8Cuvy3lNKObdiv3e0XklVqu6xKC6k?=
 =?us-ascii?Q?nomPKKG4T/OxKSjXp/G4bjrgoSfHxe6c8vMbsP6i6CEvDBqDrMtLeJl47owq?=
 =?us-ascii?Q?FxEtpyD6NvrEbh4NDGm7QNvf+2ed4OoAmb7qr/4pa3kMAzlBeL0VG+63gGyJ?=
 =?us-ascii?Q?SuYxWKXr+9zneMo29AcDiykjNuXDLbJVZjgTfpxK8Z9E6qKsinbfShm5KK+G?=
 =?us-ascii?Q?qwJs0+P3X72PPv7DQlB8LaT+bNjSrmL46hplqrHWs7+tzG/l5svPj7t2sPUt?=
 =?us-ascii?Q?bPASpqOZr12iCUaUkgv/hhmIFp/oggxtYipdfvfSQ169d4PfpVg+39bDt8xR?=
 =?us-ascii?Q?nt+nA8pidqPbOYpIbfBSYxg7Eo0N1eSBITdex1wxUbXTHlLLi1tdTJ1JnrkS?=
 =?us-ascii?Q?32CuStvHIEM8kZq+8q46ATT7+dN0InD0nJaetV1ct3edGnFCnyI1427IFA6E?=
 =?us-ascii?Q?6x14EkBBXHfHw0wYsavh/eX80Rh3moHU7RYFROtdXgnXUwtbATl661aXRO9K?=
 =?us-ascii?Q?rH5Sti1yEeTK5se8YZy6mVBbnBi7BV0m2Od4og0NJwrjm1BhD5MTF0OFow5n?=
 =?us-ascii?Q?gUWrQJTv70iuzwb1pJ7x3GUTOw7WEDtFzQZLY0ApiYgZ0w1xyKW1fSKibZHv?=
 =?us-ascii?Q?s0aM8P+DjMu4BkMb17q1DdVgPRklFnToBpAlIh4ZpLqOcfHBB+6Wg258OMa1?=
 =?us-ascii?Q?4R2X2z18gu9auFmzW8EgoRUlAl64+LmSBJYIWvfYPdIOwRWyFkIigaXt381q?=
 =?us-ascii?Q?NCaIS51rv0XkJe7jfxYaRBQaVfsMTFPH9HUXTYRy8QOeAaucVf4Xpb1OaSGG?=
 =?us-ascii?Q?T+0qEYrJKKxvTxIN4+uC63qNenYbaTAQUtzHHt/zd+rum5gvMxCKqVjW7VMK?=
 =?us-ascii?Q?1QGo3TTko7r/BE8+in/bttWnnG8BxJsDZYdiCrWdDV01DB7v/meZjc/bBah8?=
 =?us-ascii?Q?iWCdIlNWnSL0BeBNmVQbQv1pLy7Z0ryQI5aA4p+fZL37eTNQ1efAf10HkuAo?=
 =?us-ascii?Q?8jEL7/6uPTuRxBMGfAAoSth1/Y51NYCIE+dJwUkB8fJPajjnwYvtayPjZt59?=
 =?us-ascii?Q?t5F3GbkhN4F6n8F5fgMulgbHODR/TjTURX2IHKniXws1tQz/f/D7NGPBALp7?=
 =?us-ascii?Q?4S+47UwYbkFV5kJakj+LevLykiobVtPiSMgDcvydg9Wbx0NKcL8q/eud44ra?=
 =?us-ascii?Q?zlTBaPgXLL+MIYObY46QS/D5lfTWdv0mJWRAc5dtW+SU21nWC+2PIwyMfMLA?=
 =?us-ascii?Q?UoGKRBojpOcQdx5XwYdJsm2anEZcZ7bJgsq1FudFqBM7fjSk3FBH+iKToJMX?=
 =?us-ascii?Q?B7hqzkfY7Ga63+bm+UaVAVnr3GvEpV5JwgVhMJJ1sblx07y5/nJ2v9MbrAGU?=
 =?us-ascii?Q?SvSFvQcfTAAm5SSbJih0hYlA8GaCPXGZJFrKbkI80vVjT0WEIBhPW+NnUIxs?=
 =?us-ascii?Q?vCB+0D7Y3HsGpguCzj3OFa7/fGSzX8/N80gMIRK+qLXljj/BSIjQBV2Y/q5g?=
 =?us-ascii?Q?YRwqOmcxOmpoMOx1O1OYE7E0UeiMAwy83b7i4W1s50qolxEm5Ity4d5b3N9T?=
 =?us-ascii?Q?OMsBFCeBCw0faunpnhqGdVTYlv8fP1gHIcojUqC9HFs5JKe/sGK9OM6xk6HP?=
 =?us-ascii?Q?tdSHH8QktA2R3c5U4vnc//WGBPH3TJ+0i12/ujZ7paDupDG4mihQpqLbecHt?=
 =?us-ascii?Q?zhpTKKKy/A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be6e5d0-0c90-4b1c-a753-08de64155c68
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 17:46:44.2099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cTg3WFpZuY+NeRVesJyBjLtSwsSiH1oiyBN3oU/8dI1h4YanHtgdgmNTqs+qHX0zG3cOp6mevNmNg0TPyKoRxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11340
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8739-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,valinux.co.jp:email,nxp.com:dkim]
X-Rspamd-Queue-Id: 05A0DEB383
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 11:54:32PM +0900, Koichiro Den wrote:
> Some DMA controllers can generate an interrupt by software writing to a
> register, without updating the normal interrupt status bits. This can be
> used as a doorbell mechanism when the DMA engine is remotely programmed,
> or for self-tests.
>
> Add an optional per-DMA-device API to register/unregister callbacks for
> such "selfirq" events. Providers may invoke these callbacks from their
> interrupt handler when they detect an emulated interrupt.
>
> Callbacks are invoked in hardirq context and must not sleep.

Is it possible register shared irq handle with the same channel's irq
number?

Frank

>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  include/linux/dmaengine.h | 70 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 71bc2674567f..9c6194e8bfe1 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -785,6 +785,17 @@ struct dma_filter {
>  	const struct dma_slave_map *map;
>  };
>
> +/**
> + * dma_selfirq_fn - callback for emulated/self IRQ events
> + * @dev: DMA device invoking the callback
> + * @data: opaque pointer provided at registration time
> + *
> + * Providers may invoke this callback from their interrupt handler when an
> + * emulated interrupt ("selfirq") might have occurred. The callback runs in
> + * hardirq context and must not sleep.
> + */
> +typedef void (*dma_selfirq_fn)(struct dma_device *dev, void *data);
> +
>  /**
>   * struct dma_device - info on the entity supplying DMA services
>   * @ref: reference is taken and put every time a channel is allocated or freed
> @@ -853,6 +864,10 @@ struct dma_filter {
>   *	or an error code
>   * @device_synchronize: Synchronizes the termination of a transfers to the
>   *  current context.
> + * @device_register_selfirq: optional callback registration for
> + *	emulated/self IRQ events
> + * @device_unregister_selfirq: unregister previously registered selfirq
> + *	callback
>   * @device_tx_status: poll for transaction completion, the optional
>   *	txstate parameter can be supplied with a pointer to get a
>   *	struct with auxiliary transfer status information, otherwise the call
> @@ -951,6 +966,11 @@ struct dma_device {
>  	int (*device_terminate_all)(struct dma_chan *chan);
>  	void (*device_synchronize)(struct dma_chan *chan);
>
> +	int (*device_register_selfirq)(struct dma_device *dev,
> +				       dma_selfirq_fn fn, void *data);
> +	void (*device_unregister_selfirq)(struct dma_device *dev,
> +					  dma_selfirq_fn fn, void *data);
> +
>  	enum dma_status (*device_tx_status)(struct dma_chan *chan,
>  					    dma_cookie_t cookie,
>  					    struct dma_tx_state *txstate);
> @@ -1197,6 +1217,56 @@ static inline void dmaengine_synchronize(struct dma_chan *chan)
>  		chan->device->device_synchronize(chan);
>  }
>
> +/**
> + * dmaengine_register_selfirq() - Register a callback for emulated/self IRQ
> + *                                events
> + * @dev: DMA device
> + * @fn: callback invoked from the provider's IRQ handler
> + * @data: opaque callback data
> + *
> + * Some DMA controllers can raise an interrupt by software writing to a
> + * register without updating normal status bits. Providers may call
> + * registered callbacks from their interrupt handler when such events may
> + * have occurred.
> + * Callbacks are invoked in hardirq context and must not sleep.
> + *
> + * Return: 0 on success, -EOPNOTSUPP if unsupported, -EINVAL on bad args,
> + * or provider-specific -errno.
> + */
> +static inline int dmaengine_register_selfirq(struct dma_device *dev,
> +					     dma_selfirq_fn fn, void *data)
> +{
> +	if (!dev || !fn)
> +		return -EINVAL;
> +	if (!dev->device_register_selfirq)
> +		return -EOPNOTSUPP;
> +
> +	return dev->device_register_selfirq(dev, fn, data);
> +}
> +
> +/**
> + * dmaengine_unregister_selfirq() - Unregister a previously registered
> + *                                  selfirq callback
> + * @dev: DMA device
> + * @fn: callback pointer used at registration time
> + * @data: opaque pointer used at registration time
> + *
> + * Unregister a callback previously registered via
> + * dmaengine_register_selfirq(). Providers may synchronize against
> + * in-flight callbacks, therefore this function may sleep and must not be
> + * called from atomic context.
> + */
> +static inline void dmaengine_unregister_selfirq(struct dma_device *dev,
> +						dma_selfirq_fn fn, void *data)
> +{
> +	if (!dev || !fn)
> +		return;
> +	if (!dev->device_unregister_selfirq)
> +		return;
> +
> +	dev->device_unregister_selfirq(dev, fn, data);
> +}
> +
>  /**
>   * dmaengine_terminate_sync() - Terminate all active DMA transfers
>   * @chan: The channel for which to terminate the transfers
> --
> 2.51.0
>


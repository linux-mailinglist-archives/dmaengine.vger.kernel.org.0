Return-Path: <dmaengine+bounces-8671-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AYlGcTUgGmFBwMAu9opvQ
	(envelope-from <dmaengine+bounces-8671-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 17:45:56 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EC70ACF1D1
	for <lists+dmaengine@lfdr.de>; Mon, 02 Feb 2026 17:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9AD6730327DA
	for <lists+dmaengine@lfdr.de>; Mon,  2 Feb 2026 16:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8AD280CC9;
	Mon,  2 Feb 2026 16:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="X4qyb5EV"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013063.outbound.protection.outlook.com [52.101.72.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3544726562D;
	Mon,  2 Feb 2026 16:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770050568; cv=fail; b=p94kAi1XZXyO1auVLWDM1c4Ph0b4YNA5/P5YxoUZYAKl/y/UiG9wWbSCvICAwmSXYcM4P7OUrt3vaw4RcMWcRUWN1SMVw0c8CvVTzofO1LPiq6H7ljlpL1kGclhiZQL8xk3lXyyXikbTMAJFqV8Zk6gfomlXBxY9yjBh/+mAc1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770050568; c=relaxed/simple;
	bh=BBx+GDvHVJKRBQnaV4dsgbVI92eDfbXmKGL7lrtP2fU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=goZj7amf+3w5kt5FQ0PzGobZgT2IZTp5VIjgJ0IUXiUQU13WCoTk85xb+8FJxEiuw/zlv3kEK6pGvqCsK4SUcBPmKxszVv7kITp2vrb+qt+sBNxpWX7fG09QraICBkwy3yGy+WkD4KMPy9g/lCcj6ogJ0F43GctXb7eb9PboWbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=X4qyb5EV; arc=fail smtp.client-ip=52.101.72.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rx0ZISK7oD9v2QsUcPUgCbpJaKWQqCCIdwSQcOnJ1U00g6qRm/ZbisRoJJwGZ+Bx0HuPLaEizGY7DB8CxRwx+K/crXrNTjfPGiAV+jfMqPdxR3BE/I2OCtq3vZHyldVj7w0TWa5gAKdD2kx5M95ltpJbwlUDLa3GgKe9BFlEcUQdtumUwglHgkFORUndYTReWDEN6IUISYisevhIlkg1VcwYFS8+//90hFte2S9BQInS6iMMeoY+0fWGrOx51C0SeIeqrMOtkwbjq0nj7XwkjA7hWNY247MZcBU58tvywOapz+uc8hvYmUNBcUgsPpt1kkd+pf23a2nTMCSeIv1aNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/W62JozsO9dTnH3EH1+GD7FAOCyIv90jGJRnobHv2HI=;
 b=k+V2PM/tevCAWII6WAHHDP82ISodb9TKW3WnObkGGqRzGz02gYzzmJFFtv1IAJbxIq25ofzh6G4kQjDY3jFIiHpP7aU7ODjj6Pjel3+u74jP44HhEsTrq8dxlbsQi3UAxU49O0vlwtE5TylocRXHAq6juvpsU4y+qi4nB4WYUX84+3aqR9WgyC3WyErX3kJg8keSyxKEd7+HwaPFOZBCEHsn9CSaRu1FUzcy8IlW2x2inMMRozSbDvpm/B51EVQBl8tPjwJwk6yor7S6OnaeGKqNVbyAlBMXehVZeoK1Q+hcyKoZ5U5FD8fyy0e7EgWNxMZyYKWH93FXjxD0N43AqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/W62JozsO9dTnH3EH1+GD7FAOCyIv90jGJRnobHv2HI=;
 b=X4qyb5EVNt2xKKOdgAVtjI1/70VautHdNkeDDcrig6LaoiaEHTcIe8kHJdhXvdoX+kN7+a+VZkO8LinqfK8pbUFjGn5LFnezrgyblL7TY4lak2f9iPHI7Uuo1+jdhCiDTbYQjU6uqEk+Low41SYuHfZsQzTbIouv6i3FjWJXSF3zwg7FZSzwX8wsoe0lJ5zd5TkvGZr0AGrERF8rWb50EaWR9K7maAzaHurIFWiiI2bWx1U27EZ7yKHm1NR+Lt0NtMvfTrzwep6LoU6zX5Jq3j6MZte2klnChCei3aaxQ1DOW9JtNW/D6V6el2pDZovIYWhD7CT17MO3Fwo6cKjECA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DBAPR04MB7351.eurprd04.prod.outlook.com (2603:10a6:10:1b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Mon, 2 Feb
 2026 16:42:43 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 16:42:43 +0000
Date: Mon, 2 Feb 2026 11:42:34 -0500
From: Frank Li <Frank.li@nxp.com>
To: Shi-Shenghui <ssh.mediatek@gmail.com>
Cc: vkoul@kernel.org, manivannan.sadhasivam@linaro.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	brody.shi@m2semi.com, kevin.song@m2semi.com,
	qixiang.zhong@m2semi.com, tom.hu@m2semi.com,
	richard.yang@m2semi.com
Subject: Re: [PATCH v5] dmaengine: dw-edma: fix MSI data programming for
 multi-IRQ case
Message-ID: <aYDT+meppNfX9bD3@lizhi-Precision-Tower-5810>
References: <20260202055344.1395-1-brody.shi@m2semi.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202055344.1395-1-brody.shi@m2semi.com>
X-ClientProxiedBy: SJ0PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::17) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DBAPR04MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: 7301fc8d-5b77-4fc0-dc64-08de627a1630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+FzA1bY5s/yIqApm6BOwG0PtD1fViRywObFIu+g7L8phHpRUYWluqdMs12bE?=
 =?us-ascii?Q?h4MIsG9h+0eUF8l1UOrKXZSr8O+dvJPsoKSUuZ056zyQPEF1rgCqoeEBwuMg?=
 =?us-ascii?Q?LCyJfpoxivOXBQJMezVCAAHPWHoRSHmHONLpQ/cNo7ecDTc8J+g+fU8moqce?=
 =?us-ascii?Q?RwXY4CThTOH0wyLnrzsfcP9It6P5zAEpew74AIjQZCr3J/Z4McBMqHROn85j?=
 =?us-ascii?Q?He3ritCwXXJmhX1Br+rrSPjT/2BOj7QIGD87FfdqRObLtf1ZnyHTjgfhZWzf?=
 =?us-ascii?Q?Uk5fQXDzQq2YCoXUaliWr+TMA7bEwX5Sw1Y82QB5QTSd7JaYuaen1vVYTAAL?=
 =?us-ascii?Q?LDFemd4sSbC+/CXa2Ar49B0yzo643S9yp9kxyxqlihHWxGQ9enE9n5iYh3gx?=
 =?us-ascii?Q?EXLe5hDKo6dYLB+Z5+1ZisUx3vBsNPO1cZ3LiRKU+bZTeUW0RK76WgtOxslF?=
 =?us-ascii?Q?WVbtoUkzAU2oTkoo1lXqcmMMy9isvzA9xifOJ4E3DG85pGbLMWl397L6L22K?=
 =?us-ascii?Q?LW18BEErKfVIWKLlN+4aV1hqBisusB9PKaFicJIElmUHpxkhE00BnLlkLP+K?=
 =?us-ascii?Q?ZVmSMCzpTnxIhMMfWVHxEBP8Gx6DMPSoBrQFtKmqcB3cql0sf+YOqMNrsMvq?=
 =?us-ascii?Q?sB6v0PTSC5CtO5IWxQt4Ml8H+t+FX2V47Yb3FXGIWG3uaLrIOZCp2pTLPwM7?=
 =?us-ascii?Q?AKurNnQV4BzWnZJ0BYK+3vMwW5/P6XeLJVeZMxGDARhKrr40YvRtu6KwRJJE?=
 =?us-ascii?Q?0Xnpx7ctKZVupKwWzLEF1fp5pOvp6IPyXXHEPKrSqxkack1i3gdjDTWHvEB/?=
 =?us-ascii?Q?cYzkRJtNfK+KwQoJt0ITdPn2BHsd+e499fxv6Twt3uBNu0QK8XjUhXAe8aap?=
 =?us-ascii?Q?5Cri61xhRIjCz4pZqYBJRwiUPVj/7cW0J4gOR70xXeI4YtDcux5tg/sdLVfJ?=
 =?us-ascii?Q?AwGvDxZmK5Tp2F/A69KshqVBPbDqlDnf2AcgsQ+OGHzecxovqsmQcQ1ckFF4?=
 =?us-ascii?Q?wa+2lms1BPU+lwxcg1NlnnVCQ2FntfBNmRvwL/QxXwnqr8/ygitU5j4Tm4d/?=
 =?us-ascii?Q?XDJ3mhh4pAde4aNIXCgdarEAEJPmLTQ5IwP2JdmuhzvuxSCSfFZZB8q2MiDB?=
 =?us-ascii?Q?oN36vD9Gpee/DYO3WqdJv74nabPAZBRXHjM4WCwZG1aIaplJt4ctH8OVrads?=
 =?us-ascii?Q?sAw3uFdZPX2tDB6fojF8v/4htpJny6fDlBfA9NeRiVbVRTFTjvs/DUTdBwxh?=
 =?us-ascii?Q?Em9oZHFc5Fm5f5SmRRvb+K/ZUCi5T0Il5WiBYKGVeNXPJaRvSsTvggn4pq/g?=
 =?us-ascii?Q?TSezqLUzAsg59jopfCJPbr9n0a1rVSrDZIhFNGn6C4chDlF6Yuvu6Y1ZFB1V?=
 =?us-ascii?Q?OLQXuoCnD+n4kUn/R5t1sylZxeQf3nEQ3tTwPAIy602mrmvWX4SBtpbO/lUK?=
 =?us-ascii?Q?QrMLhaI29Ki0hYyyHWkuq6V6arR/I/UGD/F6dnsLn886xrcckYj4IOdYQzpW?=
 =?us-ascii?Q?cfnUs3tqf6x10ogcIX0eHvlUO/9Ydc+fID9I39a8VQ2gmQ0S91ECdthb8bge?=
 =?us-ascii?Q?thny7hdtGHmv1IdWC+2LutSPJ71Nt26IN4dhJd+FNu3FLBFaf8Mb4gCpk2Uk?=
 =?us-ascii?Q?lxCIZMQT1Ic4nLtRCtpF78Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(52116014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vjAaaEi9le5m8hreUiFmGHdR66ges9fTBQ9pldmCkKUIzKgqFreRenKFUvtb?=
 =?us-ascii?Q?8TkDUBk+GWO2YshNI/atxxXgW2UgZFdWR1Fbb/pEkqapcNMF1zx/3NOmE5Ac?=
 =?us-ascii?Q?mOBuJJBZYlxmiUzMhGAOpnKQU2CT9As6OFebtK4AsnzOt3ZGD8AkNvE7Hrgq?=
 =?us-ascii?Q?WA+xolZJgsvk41LLtfpB8eXHx1/e3U07gIegBuXcdUOu7/R4bEGx6bXyvZ8Z?=
 =?us-ascii?Q?PCYoYNjbxO6ceZ1uuyZUuRx/Rgd+a9SrRZIXUCeoKkyrWlQrl6kgZrC9hUZG?=
 =?us-ascii?Q?QwKLmK1TZr8A86d77uddGj3DcI+GlqprLKhz19B4w1+B9MRbcSOnVASz9EBF?=
 =?us-ascii?Q?NRpxVjslpEjhqIOgF9PPJQz3Jg9y2ceF5/m/IyFUlyL4X85fdCvqZSWxJbmU?=
 =?us-ascii?Q?cEo8WFOz5g/RprfOxJOTMaYAOiK2jpFwBaUy74+c0rEAHfmRlUPLyS8PnY0u?=
 =?us-ascii?Q?SzUUDsp34zcoU9+1X9SXo/gJpijPV19nVHp6u7YpK7K8IQee8Hm+otpspbE6?=
 =?us-ascii?Q?QYsWBiu8BZLtfVrgWJISOryNfWAKv22CPYfenoAWaOej3xGfcJF/08NdI+KH?=
 =?us-ascii?Q?8nVHkvrimQBV95pExVa6pKcGfO+/lc/glvrZCmrzc6q4Tq1Zy1ULp8bf0f3n?=
 =?us-ascii?Q?1v4DdVgOwJvHN6ANP/t18fwtWx9CCiWviLRfR1nroqVeSf6WmMY/0anRrhIJ?=
 =?us-ascii?Q?qVtfbW+aULclYHw+MWG5J42ECxrzCZBU65WEGO+r8almcF5blUfuvW3FkgO4?=
 =?us-ascii?Q?ZVMfDmH+BhJi9/7/MP2kINfUYPBWTY7ENxQIV3TaVEjMbf8LOCJS1ANnctnl?=
 =?us-ascii?Q?a9l9jAkWTUw1WHRl20x7Dt2VJKAcNoHEpESq6V8VhL1irRnl3WQ6wpe4vOQf?=
 =?us-ascii?Q?YKNUxXZJywDVZHR/UXvmqiHFjGiLuVKcwPChb3eFZFNXZOLkhdDw6KrLRr8L?=
 =?us-ascii?Q?JRhEuf+k2p7KWHJDi2XExVpW8+n3f04FTtqMTb5Hp+7JgQi3kDt++ESwkAY6?=
 =?us-ascii?Q?eGN0Ul/wfiFt+g9/vip81poZd2h045qZwYHjIF+zPE9S5tgHa20/QPpRQ9XA?=
 =?us-ascii?Q?H1miuFFUPd+uYZ8preonHpZ6ZByNv6g9CK2GNabbOhY8ox9Am1Hu/jeCna8n?=
 =?us-ascii?Q?dpSyB4eKMOYROGktEQEHW3QdiRN1Cn6et8JGh3kw6QF16i07V2pVXFzqQk6g?=
 =?us-ascii?Q?dEqppQvweiV9c73QonlBuvZjrzK5e2pqPXFEsV0w/ndeiYOnXNg3bZrYRPpO?=
 =?us-ascii?Q?0LfjJFPSV6/5NR+2K1eNQS5aJiY08LQ20fQ/ij97kjmTYu/32XB5j2uKmUT3?=
 =?us-ascii?Q?JzhYsM4yhlPLyar55ghr1qRcSeRt2YO5b+YBLbADiPerbfcEDYpDMrZDjK3/?=
 =?us-ascii?Q?qFMZerlqSoSp/qBnicxA+YnexbifEvT421h9xXwLi8tHTt5BvDPCpn+2PSbV?=
 =?us-ascii?Q?i6h+bNnE18v3hYUBBA0GPQPXHpF9vpjiLRUkVPhaASGw0ir7FXI7dsVJkyCm?=
 =?us-ascii?Q?sRZOmuDvH0y+EfhDccsFn1bfIvdlc3bN+8kkdH7eH7ChEvm3kq1/Xgnsj1Zz?=
 =?us-ascii?Q?ib9ZpexctWsNyYwPTbruGstYWPM9XcDb0rPBqHogDVeUBupgo/C7c+6ztlEw?=
 =?us-ascii?Q?eryQcziR5GymgKxcEYoPvxVrIW5HWR849mw5SsxNHzN87FzZ3RShVvXXZgHy?=
 =?us-ascii?Q?LLxnD+DcanAD4HBXF4A2nnKA2cyytRn0ZTJ8BV+5bDHfFChG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7301fc8d-5b77-4fc0-dc64-08de627a1630
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 16:42:43.4320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Jv7vnbzfGtE2bwF9mdux7wJh8WtYUHuNvyJqxY0554qAU9qlC7A2J+EGlq/PSEDS0UTmWlRY6OpeT9bNEP4rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7351
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8671-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC70ACF1D1
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 01:53:44PM +0800, Shi-Shenghui wrote:
> From: Shenghui Shi <brody.shi@m2semi.com>
>
> When using MSI (not MSI-X) with multiple IRQs, the MSI data value
> must be unique per vector to ensure correct interrupt delivery.
> Currently, the driver fails to increment the MSI data per vector,
> causing interrupts to be misrouted.
>
> Fix this by caching the base MSI data and adjusting each vector's
> data accordingly during IRQ setup.
>
> Fixes: e63d79d1ff04 ("dmaengine: dw-edma: Add Synopsys DesignWare eDMA IP core driver")
>
> Signed-off-by: Shenghui Shi <brody.shi@m2semi.com>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/dma/dw-edma/dw-edma-core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 8e5f7defa6b6..dccc686b7a3e 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -844,6 +844,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
>  {
>  	struct dw_edma_chip *chip = dw->chip;
>  	struct device *dev = dw->chip->dev;
> +	struct msi_desc *msi_desc;
>  	u32 wr_mask = 1;
>  	u32 rd_mask = 1;
>  	int i, err = 0;
> @@ -895,9 +896,15 @@ static int dw_edma_irq_request(struct dw_edma *dw,
>  					  &dw->irq[i]);
>  			if (err)
>  				goto err_irq_free;
> +			msi_desc = irq_get_msi_desc(irq);
> +			if (msi_desc) {
> +				bool is_msi;
>
> -			if (irq_get_msi_desc(irq))
>  				get_cached_msi_msg(irq, &dw->irq[i].msi);
> +				is_msi = msi_desc && !msi_desc->pci.msi_attrib.is_msix;
> +				if (is_msi)
> +					dw->irq[i].msi.data = dw->irq[0].msi.data + i;
> +			}
>  		}
>
>  		dw->nr_irqs = i;
> --
> 2.49.0.windows.1
>


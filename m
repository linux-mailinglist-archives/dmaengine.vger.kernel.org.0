Return-Path: <dmaengine+bounces-8825-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BjzxG+1+iWlx+AQAu9opvQ
	(envelope-from <dmaengine+bounces-8825-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 07:30:05 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EFF10C087
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 07:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D019A30062D1
	for <lists+dmaengine@lfdr.de>; Mon,  9 Feb 2026 06:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4372D2FE048;
	Mon,  9 Feb 2026 06:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="a5eB+E60"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021104.outbound.protection.outlook.com [40.107.74.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69082ED154;
	Mon,  9 Feb 2026 06:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770618603; cv=fail; b=XA3CNuSBsBt8V93vVHZpBY/DcolfF9X6tNNlU+f/s4Ey+XKbndttONL5ljT/bGnQq+Mikp5gt95eAgWaFrIkauokgS3LPv168HgoL69M2eC0xWufh1ruIJzVE6hU7jxpVRuJpUDTd+eVgpCYphy071SGcHIPyxS5oCoaLODSdSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770618603; c=relaxed/simple;
	bh=LMPeG76zaN7/1vJRvj/3N35XHgYnWdSP9xVsfUjo45o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hPsPMeixwStXQugsjT9gM+jCMCQx1OJGi/fXcHp8LIEq896axiAdGTGLDqANRHJAqrxqfxpMDxqaHB/DS+C0xo+giKGLqURakVycSkL3t5zKdiMms9m0Yl+nWGvSafzZXPvfW2w74inr9xAOsdosGq5bCYbg7Cy+HjlCyJvKGwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=a5eB+E60; arc=fail smtp.client-ip=40.107.74.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e531d505+Z4hkQ4EgCtI3V12VnQrMlVbu76bm4TeUB7uUjqn48nTEAqwrupqmo68VhYjYR/Fs4Ah43VaxR+f9A8DrcP9tPeZULN+Nf0HphpEsYR8CNm/2Q/j6eY9KdMg99RKck4QyMO6ObHVgZNApRXl8rB/Pi6J+W1Juw54updCnZKweQPt5cpwiYG4CqDBfYdeSnoiCQrTQospUx2MLZ5obOprNd9BSmZ36Xux03R2EsM4voM0CgduRc6gHdlg3uSRa2J9wzRcDj4ttGUakp0UlMBpKsVqCTicn6crRGhsyMkuq03wuYywdcQCaPPCpCB8jKoS0MX1Sc+qwVeOfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGIqxRGFaq1HG5iwebCn64y/g2AUOrVzlmhB8S1cZGg=;
 b=FUrC8ViR102b/YLthBKZ5FYwn3YXtW8J0ku9cLBdCl8I4FgDxd+HJqrP0BsBgu81qei0gW+fwuqofcktknIUmiTR6/EF10W1Lq8pQZa8zkdEIAN700xjvi80WWFVjWdbxruHlgqNOIrhKIzAPoxlaMiN0xGHXbd8Zs0s2CSXIwMcIlDw8yxnXIyyBdBR25N4ehDa93HX0iwHVgOP7Xncxg4Cgj0UaEEoH8FJ0jRqVnmMyozwPJJLdFjSyDNt4kfSJAzi8RLlrdh15hRzCATTlAyPysdmP3LUtus412+m4jImahlQrBIWE6p+15F5K385gJAaE3A6sXGkyPk16WVJxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGIqxRGFaq1HG5iwebCn64y/g2AUOrVzlmhB8S1cZGg=;
 b=a5eB+E60CNdBoWOGRKGff8bFS1MVCTPdQjoI6ooxCtfqehF8yAQ/kCNqbYHhIf20rA42AhqduEPowmMnR6lYBzTU2712JXQYua9GyOEfHp1qSXujfN+JuWaB8ktSb2Vf2hKGb73baYG63ugHr0ZxmiTJnRsRxSs8W6fsXWf38CY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4425.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:10b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Mon, 9 Feb
 2026 06:30:00 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 06:30:00 +0000
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
Subject: [PATCH v5 1/8] dmaengine: dw-edma: Deassert emulated interrupts in the IRQ handler
Date: Mon,  9 Feb 2026 15:29:44 +0900
Message-ID: <20260209062952.2049053-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209062952.2049053-1-den@valinux.co.jp>
References: <20260209062952.2049053-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0319.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4425:EE_
X-MS-Office365-Filtering-Correlation-Id: a1deff82-ee0a-4bca-ddde-08de67a4a69d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HEDNr9CxsBwkKCvfF4P7NEnwQ5P9cLjKBY2KDJi78YX1EKcvUduGCkyWAnIu?=
 =?us-ascii?Q?RaKsk0mXGSExyT9zbbOGRueTFu5EN2GiJucP3c7EezxHNFrcKQ5CZ8Mnf2Nh?=
 =?us-ascii?Q?sxESeV8XG7TEdODdDU073I1X2VtXfgBS83F/vB2eZgjz1UQgpKTZwaWFHiwu?=
 =?us-ascii?Q?h2EPi214oPjzqMxuXgidMWHSaStXwi5T18Z4HDeDSMg3xblWBHv7bNxkWytm?=
 =?us-ascii?Q?F711ncBUUag59k+U59+tYP3EaKBVUIri6s6LOYvq/7MXFXQgNnnOvg6QP41b?=
 =?us-ascii?Q?DlNQo43kk7+PPQlj41YYWEYBb0K3QEeih9j50pyUHsxV5h3njfMV7+KC6Qqe?=
 =?us-ascii?Q?lCTzvnQ93FBBEPc36ettD6EajZ2fF11TvfXWp5T1DhD55JrvqoB0+AAHcEQC?=
 =?us-ascii?Q?kf+mn5j7R+nHTXky/ymtk0s/1i7J4OomiluhIRx9wBYwnZ37L/rbdAnW58S8?=
 =?us-ascii?Q?9tyLdn9i9bzfZjVeAw6C1mcLaETvep6NcsdyAYaNM+6+420laIg4+CkqPBta?=
 =?us-ascii?Q?b5hq4ahX1zFY6+/QgTHTd5x2pLbQ2ZYPJTFg19V4I15A2f3lMxqJmZnRTmzj?=
 =?us-ascii?Q?b/fBbkW1tcC1FKL9f1iea1+WkeoqpW+hantRz/3keEc+54fapyUCl201UgVm?=
 =?us-ascii?Q?w7IMJ8DY0Iwcnti4iL3tl1P5ylNiw1bqFLBV/AG7UBm8JSzXTQxwlcADUT56?=
 =?us-ascii?Q?Fs7ESQjZgRkKHHd/gDK1GY5VTBFP47RsWlt3m9G5aj50O9pwmaSvGPgSZhMf?=
 =?us-ascii?Q?yksgthtjABxCB3+KCF0ISkCGcpAw1LrgQd6Ztg4XibyLk2mZnCV2jM+LeO6/?=
 =?us-ascii?Q?o6gMjLRwkbkvOz5qWks4N0Vo0QuibzigYILQhsfOKo3D0xWv0rJWsHQHZFB7?=
 =?us-ascii?Q?K/H5qs1gwmXfh/RPS/IlVy922ltMjumblrEU9HCKu7i8rOpFDEpE7SZgterc?=
 =?us-ascii?Q?paJwV0imef6Kuf6qpvvfUs8T2UtcJq5YtEkVlFjSeNPXeoPj0TqQvZybQ9D8?=
 =?us-ascii?Q?kNyCWBUa0731cuuNpu1G/F0mM3vZtstZnpssswVCLfJVF95xczPAGNEwv0pE?=
 =?us-ascii?Q?GNHHo/1y/Tw09iK9grk/bKogHwSlpSjRq09sG2JZcg3mYE36trhKvZ05SEVr?=
 =?us-ascii?Q?jTZmWc6ewTHthj3KuyV99syDxQsdSEYqXQnCSMikWWoESG04pe5aWvGA0Wgz?=
 =?us-ascii?Q?e6TkXGU8/ejjtYb77+mAGyuGQ15zyV4osEyAV/3/tTSe5Fla3KCNAS4XCEZK?=
 =?us-ascii?Q?FUOXiSJ+2gKcI73mAFJdj5RfcLB+TfM+KD9yPfCM+E6KTcZyjLuuy2psF03X?=
 =?us-ascii?Q?Ly6BABfkPSnfRl+eejAZDTmm+qnBLcTKiDmnwLkpfEK5IO8ISr5XwJUflaRK?=
 =?us-ascii?Q?r75U/KJYq6uISlqVNKnTfNUkGZBFrEef+ROlWgHQcuE/mXsy6vUdGmsjKQ+D?=
 =?us-ascii?Q?X+T9Po6X6tdleGMs2Nw46fBIIW3CoXPSZKtBhmpygg46Zm811FAMAFK0tn9K?=
 =?us-ascii?Q?TtOzdUoEPV0o80oCNMPELSO/MqKyDRaQvcjNZHxjEesq4s5dh/YjRBnDZrir?=
 =?us-ascii?Q?6rFY06SBiqA+pOYWxqqTGMDdozscY/4DiLOkZc5Ip7WwE34rpT6TSmAxSAYA?=
 =?us-ascii?Q?1w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c4BbFzGPcC7q6EH3OA7OF2yKwsGGeV/PIUleC8Sg4tzSmmSsOG7SwmZU31Ch?=
 =?us-ascii?Q?5W2ri02RIolUj34vSFsxgIgld1wXEJtFEjnrcGeoUQl6Bd/1iYtfms/3auTa?=
 =?us-ascii?Q?PHDkTnwywLFe965eUOLiJedMq9b05S2VTBsffihM5OaMkxyOjEH9Yr+8atuX?=
 =?us-ascii?Q?LlRm+QWkKWsVlJyzRjXXsEgMrdB56Rihf8SwKQR5Rpn7URdnSZklScOcXaOz?=
 =?us-ascii?Q?bEaG3o2eSYF5GPVYku/1DDgHmgiglDAN2V1BBbZsm/Rxbx1Q2AoL+ndhtgab?=
 =?us-ascii?Q?6lMiMEqrPumtGoU5THFCgMQHweER2sw4o8Md4LY4AoMElNz5O8pRJ/wStxvB?=
 =?us-ascii?Q?HdwTeOH7QCOXPtAESkmEdNQxHEvtXt2KQIBJj8XWqZFljd+TLBtLmywiDHyE?=
 =?us-ascii?Q?L6D9UMjoEZBSop37lpMvRR15WiyL2fip3sm+ag/jWKcFgHP1kEoTCuVXfJVP?=
 =?us-ascii?Q?9rqSlJLvzngtSHyIRoCse5KiAcdjWRtT6cvQlJWQ1j4OZGFgIA48SCNEL5Ui?=
 =?us-ascii?Q?SlP5iuuh58x36mN1KaSxzBau2MRGBgLX7DZKkMzw/uefcIvmsMMfvPUqZril?=
 =?us-ascii?Q?bNc0FnfdtSXrFpRbcgncTWSit5beAgUEBPQ7/v4/WFz2ZLIGL26LwH5zXzR7?=
 =?us-ascii?Q?Bv+iCXe89MNbzoYOdwr1lnUA1ZpdnGiY46d146TaPPiGgiRi1WXyedzz0bex?=
 =?us-ascii?Q?lEtIcP9Wr22poGkXlWF4l75/FseZUXOevH15g6WhdbgGyoMgTREhilmUe3vu?=
 =?us-ascii?Q?NaAoPToudF3t6cJhrQGFTxyCH+3oZ8lr4xKBIvyVWspSxO1YtIblSF2qNtop?=
 =?us-ascii?Q?l7nYprKY1nrlHoLS6wZatMXEQGhNYijiZNiGDO1lOUmUMtHIfn/G1/WdZxkB?=
 =?us-ascii?Q?aPRJDxkskYlzGrtxvoc5QgdYElZhqe44ziYcgbJBAufRdGI2E9PkFoWmLIZs?=
 =?us-ascii?Q?+mzN6SVCKDano9Pc/2tsKw4eN40kYefrXxM9vM8KbQ7oqJ74nNkfpkx+cJQI?=
 =?us-ascii?Q?qtmLlVUEL3I0bTw8WHpVq1OhXhOia8WLLePNzzR/I9mIXNEpZMdqHSTf9/BR?=
 =?us-ascii?Q?2X9crqMrTVtm5IaI8C8f5xSmuuBU+Fy3Ky9YnkPGVYai6wF4miGdVXjmE3JN?=
 =?us-ascii?Q?d5IRT71a6TkRF60tCHkDSmLI/ICkmvpsckCV/J1Qy1MSjCAVmvSjm8GgyCUK?=
 =?us-ascii?Q?HWq2UsqRduQRuGTSg18AVtwgSsQhGYQfN0O7dVHWOuNy1VnfSQI0UQwaG9gX?=
 =?us-ascii?Q?vTaGQBHeWFAaa5B9en/U+eW4MQAcxeBAiXltXQ0WLvCoB1YJin50ZJCcQFGH?=
 =?us-ascii?Q?nZCssmp64I15JujuWvXT+LrpOujuOfqFADK9RDEGLI73BJmxU4yYQ66pS01T?=
 =?us-ascii?Q?gJ2NZlBG4K7LleZ1VUerkvt2XmeL5a9Ge3j6AFUB2jHJIZTfrkVpR/vkhHdA?=
 =?us-ascii?Q?u3Ul2VpKTLQT76004Vd21E5xUSTaQuSpMwzH7J2gvZh6nU9FMMumLQoATIip?=
 =?us-ascii?Q?oUvdHjTd6qdeiqQ5ZCL6xBc9FwjErojCvi+LJHv5oQ9dp1bmFKQOMvwgobO4?=
 =?us-ascii?Q?U8mGC/z076rQS1MfXs/4KZ7WBADM4tu5hrKHiIE8IV7OSOXnW1/lv3QXmrpV?=
 =?us-ascii?Q?yEHfL3QPB4QAa/rCGSeTJvfLg/DwcR8Exxohh4XFrHxc2khEGwGkf9agUhs4?=
 =?us-ascii?Q?ryH+ZbXfCcQ5GT5q3IjlkIfVPsKn2DS2zWluA5DYzSi0klCbMNXPmLw2rY68?=
 =?us-ascii?Q?3smQ1pXu5onUwNr/D8CXAaKfvXZ+jyn9NCpodGkyLp5kQ6Vrf/Ti?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a1deff82-ee0a-4bca-ddde-08de67a4a69d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 06:30:00.1392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKf/7qZdnoLdmCpSMCfuUhLNFf06SgbuF/78visigIydnuVpPuWwJ9ygjIG7ZWs8Znm8fFIyKAdNl4HRqPoVAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4425
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8825-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,gmail.com,google.com,kudzu.us];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D5EFF10C087
X-Rspamd-Action: no action

Some DesignWare eDMA instances support "interrupt emulation", where a
software write can assert the IRQ line without setting the normal
DONE/ABORT status bits.

With a shared IRQ handler the driver cannot reliably distinguish an
emulated interrupt from a real one by only looking at DONE/ABORT status
bits. Leaving the emulated IRQ asserted may leave a level-triggered IRQ
line permanently asserted.

Add a core callback, .ack_emulated_irq(), to perform the core-specific
deassert sequence and call it from the read/write/common IRQ handlers.
Note that previously a direct software write could assert the emulated
IRQ without DMA activity, leading to the interrupt never getting
deasserted. This patch resolves it.

For v0, a zero write to INT_CLEAR deasserts the emulated IRQ and is a
no-op for real interrupts. HDMA is not tested or verified and is
therefore unsupported for now.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c    | 48 ++++++++++++++++++++++++---
 drivers/dma/dw-edma/dw-edma-core.h    | 10 ++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c | 11 ++++++
 3 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 8e5f7defa6b6..fe131abf1ca3 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -663,7 +663,24 @@ static void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
 	chan->status = EDMA_ST_IDLE;
 }
 
-static inline irqreturn_t dw_edma_interrupt_write(int irq, void *data)
+static inline irqreturn_t dw_edma_interrupt_emulated(void *data)
+{
+	struct dw_edma_irq *dw_irq = data;
+	struct dw_edma *dw = dw_irq->dw;
+
+	/*
+	 * Interrupt emulation may assert the IRQ line without updating the
+	 * normal DONE/ABORT status bits. With a shared IRQ handler we
+	 * cannot reliably detect such events by status registers alone, so
+	 * always perform the core-specific deassert sequence.
+	 */
+	if (dw_edma_core_ack_emulated_irq(dw))
+		return IRQ_NONE;
+
+	return IRQ_HANDLED;
+}
+
+static inline irqreturn_t dw_edma_interrupt_write_inner(int irq, void *data)
 {
 	struct dw_edma_irq *dw_irq = data;
 
@@ -672,7 +689,7 @@ static inline irqreturn_t dw_edma_interrupt_write(int irq, void *data)
 				       dw_edma_abort_interrupt);
 }
 
-static inline irqreturn_t dw_edma_interrupt_read(int irq, void *data)
+static inline irqreturn_t dw_edma_interrupt_read_inner(int irq, void *data)
 {
 	struct dw_edma_irq *dw_irq = data;
 
@@ -681,12 +698,33 @@ static inline irqreturn_t dw_edma_interrupt_read(int irq, void *data)
 				       dw_edma_abort_interrupt);
 }
 
-static irqreturn_t dw_edma_interrupt_common(int irq, void *data)
+static inline irqreturn_t dw_edma_interrupt_write(int irq, void *data)
+{
+	irqreturn_t ret = IRQ_NONE;
+
+	ret |= dw_edma_interrupt_write_inner(irq, data);
+	ret |= dw_edma_interrupt_emulated(data);
+
+	return ret;
+}
+
+static inline irqreturn_t dw_edma_interrupt_read(int irq, void *data)
+{
+	irqreturn_t ret = IRQ_NONE;
+
+	ret |= dw_edma_interrupt_read_inner(irq, data);
+	ret |= dw_edma_interrupt_emulated(data);
+
+	return ret;
+}
+
+static inline irqreturn_t dw_edma_interrupt_common(int irq, void *data)
 {
 	irqreturn_t ret = IRQ_NONE;
 
-	ret |= dw_edma_interrupt_write(irq, data);
-	ret |= dw_edma_interrupt_read(irq, data);
+	ret |= dw_edma_interrupt_write_inner(irq, data);
+	ret |= dw_edma_interrupt_read_inner(irq, data);
+	ret |= dw_edma_interrupt_emulated(data);
 
 	return ret;
 }
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 71894b9e0b15..50b87b63b581 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -126,6 +126,7 @@ struct dw_edma_core_ops {
 	void (*start)(struct dw_edma_chunk *chunk, bool first);
 	void (*ch_config)(struct dw_edma_chan *chan);
 	void (*debugfs_on)(struct dw_edma *dw);
+	void (*ack_emulated_irq)(struct dw_edma *dw);
 };
 
 struct dw_edma_sg {
@@ -206,4 +207,13 @@ void dw_edma_core_debugfs_on(struct dw_edma *dw)
 	dw->core->debugfs_on(dw);
 }
 
+static inline int dw_edma_core_ack_emulated_irq(struct dw_edma *dw)
+{
+	if (!dw->core->ack_emulated_irq)
+		return -EOPNOTSUPP;
+
+	dw->core->ack_emulated_irq(dw);
+	return 0;
+}
+
 #endif /* _DW_EDMA_CORE_H */
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index b75fdaffad9a..82b9c063c10f 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -509,6 +509,16 @@ static void dw_edma_v0_core_debugfs_on(struct dw_edma *dw)
 	dw_edma_v0_debugfs_on(dw);
 }
 
+static void dw_edma_v0_core_ack_emulated_irq(struct dw_edma *dw)
+{
+	/*
+	 * Interrupt emulation may assert the IRQ without setting
+	 * DONE/ABORT status bits. A zero write to INT_CLEAR deasserts the
+	 * emulated IRQ, while being a no-op for real interrupts.
+	 */
+	SET_BOTH_32(dw, int_clear, 0);
+}
+
 static const struct dw_edma_core_ops dw_edma_v0_core = {
 	.off = dw_edma_v0_core_off,
 	.ch_count = dw_edma_v0_core_ch_count,
@@ -517,6 +527,7 @@ static const struct dw_edma_core_ops dw_edma_v0_core = {
 	.start = dw_edma_v0_core_start,
 	.ch_config = dw_edma_v0_core_ch_config,
 	.debugfs_on = dw_edma_v0_core_debugfs_on,
+	.ack_emulated_irq = dw_edma_v0_core_ack_emulated_irq,
 };
 
 void dw_edma_v0_core_register(struct dw_edma *dw)
-- 
2.51.0



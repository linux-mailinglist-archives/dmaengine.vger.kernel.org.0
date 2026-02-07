Return-Path: <dmaengine+bounces-8814-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Qw9C9hqh2ngXgQAu9opvQ
	(envelope-from <dmaengine+bounces-8814-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 07 Feb 2026 17:39:52 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F53106872
	for <lists+dmaengine@lfdr.de>; Sat, 07 Feb 2026 17:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 029C43011055
	for <lists+dmaengine@lfdr.de>; Sat,  7 Feb 2026 16:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DB82BE7AC;
	Sat,  7 Feb 2026 16:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="DjQNOkVC"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020096.outbound.protection.outlook.com [52.101.229.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EF42253A1;
	Sat,  7 Feb 2026 16:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770482387; cv=fail; b=CTLl9JzD8ke3ZUxZtDOhKK1N1aLfJ2vmDxu4SQ2ISQZJa7ZnhKS2dmTyAohey9ZZl6fTjP1dGOfSqOj6m8zQh8v1fgMVkbQwBmB3fP5C24Sbd/zJahthDydqm2t0UakaiTqCr4nAeo5dv5JKsSxjvw196v2nCUnFso+KZZv1XBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770482387; c=relaxed/simple;
	bh=9y6z4x5K1JDD/UX8erMrZ7WDSFaCP8p0rCfOmY/15pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hOwaDl2BiHGtJZ1/ppvk9zLAS0IKAG74UZY5P+z8A+q8oHLhbWNGG28rvxTw1aZvqxrJkwF+pLst60WC0xOf69UYKAS/U84m9WohdL/dA6uZuNmtnNfZm2ZEFI4b1FV/1eEZ4wfavSWfFLjHoOYuz7g1k4mBfZqJ5v0/WFeNnto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=DjQNOkVC; arc=fail smtp.client-ip=52.101.229.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p++nGRdJT+hJR23oCeGLjxYgDOqtXQswIt3tXqJharNZLT0hzIXfRrziXSBpQeVrOPa9+yDlkkx1g/xlNLfPsUiCLBP5DyhHjqj2sTyHcyZLC05M+xQ7PRloBSZPvfuFpdKS7xRDYRLGTTdoKg6EkerpouF6NGfi4cqWXZ2uSMdGkRDZZc/vku/eJpxbMgRfHR1TgMuvpz6KcLN9YFxJ9e8qRG1zYU07UNxnkfs8u5llrrbmBjAbCCYR6WuthfgdDm/o+oU9OB7gl1JzhFGDAPOETktEhwcrbjCWozCVLXwfqukRoKl8OjMA6A0SW9Tq8t/q7jkCqOF7IKd9Jwnf4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2Xh/O3BvpkbvvYlCGPPLWzMG1yEkx4qYKyLxJBFJdE=;
 b=QYPNFGcst3aYjCCTfvR1eeCDEGZhMFot09GwX2Dx9PSF4XYFf4QaSXcaV8vRHwplDNJlay7clyM8b8LoZXj1uezdbWn7s9OQlI8FGP2WJWOUpKvBqKKAJ2CVc6Nyf2ZnVraNqdXxXbcMbzSI9Cw0oGMNw/CE0sZeHAIax8x1DAuTzKIKTuO0Yabq4X8OTXPtTQeVh6JQ3lOGRJiY5T7OkkfLrt8JjcJS95SEUpEjRhfvWZWBDGmUlTbzKOfWeJMcGes7lL2fYa98xj9LpJUmdL1QL/a6/gNBc0c1sFi06Zn6IULL4hHvwucENNx7hU2CJrD07fNLOZ/LjabSGjHeNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2Xh/O3BvpkbvvYlCGPPLWzMG1yEkx4qYKyLxJBFJdE=;
 b=DjQNOkVCkf9Pg6s4gEGFZZ4i9VefdRGEQIhazIQTxCVrCMylBLdMS3FtF4c+Yw8gYi7HPQOTXLvxoNpkzKuO6jJ9yXotIqkfZOZpuRfZ+zYqgfphx7zxhmYnyococQ/OTnUUF8mFdRA0Z+W88JRXlECk8e1sozL2O8QnXpY6lHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB3009.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Sat, 7 Feb
 2026 16:39:43 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.010; Sat, 7 Feb 2026
 16:39:42 +0000
Date: Sun, 8 Feb 2026 01:39:40 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>, cassel@kernel.org
Cc: vkoul@kernel.org, mani@kernel.org, jingoohan1@gmail.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/9] PCI: endpoint: Add remote resource query API
Message-ID: <ihe4sguchgrbiskeq5ht3tcti7yjzhsdhu7nobvbejbqtlr7dd@3n6p2poipy6d>
References: <20260206172646.1556847-1-den@valinux.co.jp>
 <20260206172646.1556847-5-den@valinux.co.jp>
 <aYYsfSTrrLbR_txR@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYYsfSTrrLbR_txR@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCP286CA0009.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB3009:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b4cdcbc-a8a6-44a6-05c4-08de66677e4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z0SH1ZZyjYh3zA/WVhq1qpVWbjUCW5m5iRthc6o4qw2C2SlkrGMWYgGZdu5h?=
 =?us-ascii?Q?ra8P0GnF0T/eCHJL8DwpzXOSEXBb8jV7qQoZDS47KmymjAnaeIkGkwbLIdF1?=
 =?us-ascii?Q?EembxOXBI0Y/ft/gtE5q8kMt5nGW8tWQHMu37Lr/wiIFpN57z6v38VIEh72p?=
 =?us-ascii?Q?QCBvi/ttF/Rxr9G6FqO/dyCSxZexEwooegMWqxEji+5mTmuRsx74IlXayNRf?=
 =?us-ascii?Q?q7J/vh8xhmeGP3+U79apMsioxiaPGBLH8yXAtkK/xmQN/Je/m/7qkewNXEhu?=
 =?us-ascii?Q?xTpjMCrUAoUogxi5LPAwSFaji9pXoUPH1p5xqqii5NqxeyWjs4Kx2lyhnAPF?=
 =?us-ascii?Q?tSzoqy2C3bIov+o1wg7qRThzTbIwCyR17/HLcG37v6RkVaVLfapGgtY8BeHS?=
 =?us-ascii?Q?prhm+ASrhCSszVpsZerR8O3O02t9gB1PiuDip20h0Lhe6c4w4/Vmr6E+uOty?=
 =?us-ascii?Q?be2GO9xu0251ZmRYcGJUj9+GpWbzwhokih5b8QKMNAD9qgxl596cPC3JIT84?=
 =?us-ascii?Q?MV4hI3RBCMstwPOrtG+8dN2WNRW1E6QUvhKjQcPtTBbjM0FciJdxEFzi+4ZW?=
 =?us-ascii?Q?pq/4Bo/aNo64JQbx8x7pyKdEKwhXEF6IPO4CDhA7JdV+ZREQtprB4uFfM+v6?=
 =?us-ascii?Q?NablNgr81hGFK7Le19P7kp9xktpfCWARppJdoY0R9tQgMQZYC4ChoFft0W6/?=
 =?us-ascii?Q?5RLRssVCdddFX1au5MlZwo2+mFzDfw0dsdzpgUHmdfrhHdJKKChczvFFDQ92?=
 =?us-ascii?Q?xQoDTvyks/azdlCmcmjd+U2V0l/As2lvwLHtXn22O0xpWRd+yq5R7HN9Xn98?=
 =?us-ascii?Q?Wba5ZvDw30KPKreqKJFsJfaHAtlWZhXpS+ewwDw/SYtf7IccHH0pow6kg798?=
 =?us-ascii?Q?Ilvb9w5zoHxx6xBZGj/v375IOR6bDKV+I2W+oE3qv0W3IyhxjB9IRu2TrttK?=
 =?us-ascii?Q?vaGxXrR53hS9w0X86Zfd4jV7OIfiGdv+2pVd9uwWz5B3TXO4E0VHm685ZlAY?=
 =?us-ascii?Q?45Ow2b8p/HgTcFnd9zxrvXN0aXVTY2QSPiGm/x+7IMPhr57hVtn50V4El1vs?=
 =?us-ascii?Q?cQfcVgcaj0Vrec3VQwA9Kch/R7AIgwkMORhX/CdOAPWMVxoxZlbRXNZD94S2?=
 =?us-ascii?Q?jr5uXFktJD9XiSp0OmgragKMXtqAEevsaOjHKspixABkazWS1qgQk499hAfD?=
 =?us-ascii?Q?ue5f2Yd2S0SMBWoFQBnKs9OtKNVNwz8Nt4IA0FQ352uI0mXYXrQrL6Gyv6/+?=
 =?us-ascii?Q?yPv4bWHRW6gKRacZA0NlGnLRTc0blQNhHj1RfyEoP0dfH4zfZkCv/PCXR4CR?=
 =?us-ascii?Q?haoK7Zu3EdinoYWykOh5tvGT1U8M0vVA9/Uw8bo4IPjywClOt3RUDigXne/d?=
 =?us-ascii?Q?7gfSo5XFnXF/0NCnPKUU1PxmDkt9WiAT1s1BNKn4o7JsukqnZOwOs/n/MMEN?=
 =?us-ascii?Q?kr47Oo2Cq6Xmt4U4tTLqJXx9qxsO1lIy+LDdp3tzwj2Ovo3SWuIgVO77wn4d?=
 =?us-ascii?Q?oz818ymtkw9dlrxjgJCoj16DezcOt1j+KlnhF2wBGl2Gp7nMDt2GgANS8hyE?=
 =?us-ascii?Q?6w/cEH84NYl4TGQJIw0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IoHl6fQREvDbWBB7qUMQ9jq5pf0LBjBA1qLbctmeRKJrJtyPIGlwu6hkgAES?=
 =?us-ascii?Q?Wt7OI90U0X85LzHwnc6vjjfmHmRj22FZ1k6FaTOpWJ7TQ7pFFiprlxop8bNS?=
 =?us-ascii?Q?Gul1CVTSJe/MFy76neE0SgZPV9T6X8trvsduYbij0npjSGAxchiymXqsbtfU?=
 =?us-ascii?Q?ET4eZcq4wLbANpAycQJaiflDHRwkn/C7C7zZn/zX+K2Iua/oTScGjASXCsUv?=
 =?us-ascii?Q?kcTsgq00UZB4K+1luc11BiCKt3MK9Vc6kTt4WJbAIFXFEIFZVUx1jzwJyBuf?=
 =?us-ascii?Q?yLGQFkV0EKCh2RwK2Bh5edao40qjmZ6JFERzmFy1cNcX/Fo5FVTBk67mpq4m?=
 =?us-ascii?Q?hIAKo3htchRWZ25EPW6OpVQm8JUcRmU9VaaX9JKOARjYPfB5pXja3xCPaSIa?=
 =?us-ascii?Q?/wFmviS83FFz+urLN4FQL9oX6U6vIBwSX1jYlyf5MPkeTwhG5F2rHjh44HyI?=
 =?us-ascii?Q?IcuLmiMySHviw34uxW8mCSjL+qf2R5xjSx2Ky7075XkZWYreEzxzt+8TfM/v?=
 =?us-ascii?Q?KsMPPO6UIesFgx5NryHPw3NntGs14D6tzQnYITirsDvOoH7UFyswWH6+mzCi?=
 =?us-ascii?Q?NxDpTUnlbfH83Gz5Qt89856oqGz1jv+NtrMEUDyquw4EiOyY8sNPsNKAV143?=
 =?us-ascii?Q?VxNvOfDa9bhNl59h/mBhJisctaxUGEQdmJufrygrM7t+hKnWu6iH8JlsIdqZ?=
 =?us-ascii?Q?fbfaYxFe5BlWiaHiVHgebqjrafdvWgckkw3NLqBdbtOYXzSUb5o29u3Nyybd?=
 =?us-ascii?Q?ZVVNfYjvqtl5yoQ7xZ4bntqMIH1s5jvdIioCOg9BR0Pp9GicUj2cjkO7MIKg?=
 =?us-ascii?Q?TGyqaUcY1AgngnSfA87oJ22iDov5juNWXRztiW8JjK9NVzKA70dguBiA4H1z?=
 =?us-ascii?Q?9DTeafv3B7gHJNGPhRFRUaH8QWRKAmzgTs70QItjRxxHUm1MMkP+c3ilsMMn?=
 =?us-ascii?Q?uOj+mDcn0wfkecOWfumt5LOY1hqffn38rcLtXX2mqx57DeLobDBt+SEsJsBZ?=
 =?us-ascii?Q?HbysO00gq48NqGZEheo37xd0p5EVIRjh/9DsLRNlizoLvvyudnz1h4InjcBH?=
 =?us-ascii?Q?HT3PVgHhSXWMy8v1mYAviwvzBJ7g7JllVlg6sECRFWTClVVVKIOYD5NeYZHv?=
 =?us-ascii?Q?2ogpGN/k86IYi6Qfp7BXIhZiwWNklNilHEgnFQnTsYPZCpHOQQZjc++MQNeZ?=
 =?us-ascii?Q?cvl3rGHlssQ+rJerQJSgUpraWu+PfJkFU3eBvjJhF4glI2+7QuclF/Hno0Er?=
 =?us-ascii?Q?nCx000eWESLdES6/hzP/DC6PA16xxgFDLjIGKejpti0saaSW85ssTHlhJq3G?=
 =?us-ascii?Q?fo160uGI/GV7RyqYeGP4sLcb1Ngb8UajbPZs0xNzOC2T0NC5XT0y/QI6jYSo?=
 =?us-ascii?Q?wNoENWEnF0ITNZSvsfPsX06OWMl4BqJFwRHJ9pYQEcxlHGLbtWBnDEOuhJ9a?=
 =?us-ascii?Q?AFfSPBAztMDQ3M5RNaoJ9h4eAnlYGKH/rxKh4PIEHfZ3lh+4PRpjHFT4veXo?=
 =?us-ascii?Q?122W1hm0XiqIfi9Ld52oCn20Wz2Zx1+tr1B+pOSkyTO1pAPeBOjopUFiK1zm?=
 =?us-ascii?Q?7jtsAJ9x2ud1bArHzIOYrMiZtprRuzDHQWME4N8bCtZ4rgztrAO2EN0LNh8Q?=
 =?us-ascii?Q?T/4nXQRdXw4HqQtN4SDCk2YKi+0we2vtGZr6e7jkrBZPDpld5PmajD3Ix+RQ?=
 =?us-ascii?Q?sVPkP4IzqqMRH1Wlekzsy/n4Ja6qQ+8dHw+7+oCbpnoWXoet221pz9G/cjhf?=
 =?us-ascii?Q?qd15imF9iVtnK2HRvDYKx9U2+4PH4E/bdYEMzevc/7OuXUxSx0CS?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4cdcbc-a8a6-44a6-05c4-08de66677e4c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2026 16:39:42.0441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zF2HelymIi+cxPn6Zc2OAquHVqc5yFPqIKs6XuQxCB4W3u9yFLuNF0N9E8Mwhyesyjldj8lTgl39hHB5cNeXow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB3009
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8814-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,valinux.co.jp:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 79F53106872
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 01:01:33PM -0500, Frank Li wrote:
> On Sat, Feb 07, 2026 at 02:26:41AM +0900, Koichiro Den wrote:
> > Endpoint controller drivers may integrate auxiliary blocks (e.g. DMA
> > engines) whose register windows and descriptor memories metadata need to
> > be exposed to a remote peer. Endpoint function drivers need a generic
> > way to discover such resources without hard-coding controller-specific
> > helpers.
> >
> > Add pci_epc_get_remote_resources() and the corresponding pci_epc_ops
> > get_remote_resources() callback. The API returns a list of resources
> > described by type, physical address and size, plus type-specific
> > metadata.
> >
> > Passing resources == NULL (or num_resources == 0) returns the required
> > number of entries.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/pci/endpoint/pci-epc-core.c | 41 +++++++++++++++++++++++++
> >  include/linux/pci-epc.h             | 46 +++++++++++++++++++++++++++++
> >  2 files changed, 87 insertions(+)
> >
> > diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> > index 068155819c57..fa161113e24c 100644
> > --- a/drivers/pci/endpoint/pci-epc-core.c
> > +++ b/drivers/pci/endpoint/pci-epc-core.c
> > @@ -155,6 +155,47 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
> >  }
> >  EXPORT_SYMBOL_GPL(pci_epc_get_features);
> >
> > +/**
> > + * pci_epc_get_remote_resources() - query EPC-provided remote resources
> 
> I am not sure if it good naming, pci_epc_get_additional_resources().
> Niklas Cassel may have good suggest, I just find you forget cc him.

That's true, I just naively followed the get_maintainers.pl output.

Niklas, I'd be happy to hear your thoughts on the naming here.
One other option I had in mind after Frank's feedback is
pci_epc_get_aux_resources().

Thanks,
Koichiro

> 
> Frank
> > + * @epc: EPC device
> > + * @func_no: function number
> > + * @vfunc_no: virtual function number
> > + * @resources: output array (may be NULL to query required count)
> > + * @num_resources: size of @resources array in entries (0 when querying count)
> > + *
> > + * Some EPC backends integrate auxiliary blocks (e.g. DMA engines) whose control
> > + * registers and/or descriptor memories can be exposed to the host by mapping
> > + * them into BAR space. This helper queries the backend for such resources.
> > + *
> > + * Return:
> > + *   * >= 0: number of resources returned (or required, if @resources is NULL)
> > + *   * -EOPNOTSUPP: backend does not support remote resource queries
> > + *   * other -errno on failure
> > + */
> > +int pci_epc_get_remote_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > +				 struct pci_epc_remote_resource *resources,
> > +				 int num_resources)
> > +{
> > +	int ret;
> > +
> > +	if (!epc || !epc->ops)
> > +		return -EINVAL;
> > +
> > +	if (func_no >= epc->max_functions)
> > +		return -EINVAL;
> > +
> > +	if (!epc->ops->get_remote_resources)
> > +		return -EOPNOTSUPP;
> > +
> > +	mutex_lock(&epc->lock);
> > +	ret = epc->ops->get_remote_resources(epc, func_no, vfunc_no,
> > +					     resources, num_resources);
> > +	mutex_unlock(&epc->lock);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_epc_get_remote_resources);
> > +
> >  /**
> >   * pci_epc_stop() - stop the PCI link
> >   * @epc: the link of the EPC device that has to be stopped
> > diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> > index c021c7af175f..7d2fce9f3a63 100644
> > --- a/include/linux/pci-epc.h
> > +++ b/include/linux/pci-epc.h
> > @@ -61,6 +61,44 @@ struct pci_epc_map {
> >  	void __iomem	*virt_addr;
> >  };
> >
> > +/**
> > + * enum pci_epc_remote_resource_type - remote resource type identifiers
> > + * @PCI_EPC_RR_DMA_CTRL_MMIO: Integrated DMA controller register window (MMIO)
> > + * @PCI_EPC_RR_DMA_CHAN_DESC: Per-channel DMA descriptor
> > + *
> > + * EPC backends may expose auxiliary blocks (e.g. DMA engines) by mapping their
> > + * register windows and descriptor memories into BAR space. This enum
> > + * identifies the type of each exposable resource.
> > + */
> > +enum pci_epc_remote_resource_type {
> > +	PCI_EPC_RR_DMA_CTRL_MMIO,
> > +	PCI_EPC_RR_DMA_CHAN_DESC,
> > +};
> > +
> > +/**
> > + * struct pci_epc_remote_resource - a physical resource that can be exposed
> > + * @type:      resource type, see enum pci_epc_remote_resource_type
> > + * @phys_addr: physical base address of the resource
> > + * @size:      size of the resource in bytes
> > + * @u:         type-specific metadata
> > + *
> > + * For @PCI_EPC_RR_DMA_CHAN_DESC, @u.dma_chan_desc provides per-channel
> > + * information.
> > + */
> > +struct pci_epc_remote_resource {
> > +	enum pci_epc_remote_resource_type type;
> > +	phys_addr_t phys_addr;
> > +	resource_size_t size;
> > +
> > +	union {
> > +		/* PCI_EPC_RR_DMA_CHAN_DESC */
> > +		struct {
> > +			int irq;
> > +			resource_size_t db_offset;
> > +		} dma_chan_desc;
> > +	} u;
> > +};
> > +
> >  /**
> >   * struct pci_epc_ops - set of function pointers for performing EPC operations
> >   * @write_header: ops to populate configuration space header
> > @@ -84,6 +122,8 @@ struct pci_epc_map {
> >   * @start: ops to start the PCI link
> >   * @stop: ops to stop the PCI link
> >   * @get_features: ops to get the features supported by the EPC
> > + * @get_remote_resources: ops to retrieve controller-owned resources that can be
> > + *			  exposed to the remote host (optional)
> >   * @owner: the module owner containing the ops
> >   */
> >  struct pci_epc_ops {
> > @@ -115,6 +155,9 @@ struct pci_epc_ops {
> >  	void	(*stop)(struct pci_epc *epc);
> >  	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
> >  						       u8 func_no, u8 vfunc_no);
> > +	int	(*get_remote_resources)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > +					struct pci_epc_remote_resource *resources,
> > +					int num_resources);
> >  	struct module *owner;
> >  };
> >
> > @@ -309,6 +352,9 @@ int pci_epc_start(struct pci_epc *epc);
> >  void pci_epc_stop(struct pci_epc *epc);
> >  const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
> >  						    u8 func_no, u8 vfunc_no);
> > +int pci_epc_get_remote_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > +				 struct pci_epc_remote_resource *resources,
> > +				 int num_resources);
> >  enum pci_barno
> >  pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
> >  enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
> > --
> > 2.51.0
> >


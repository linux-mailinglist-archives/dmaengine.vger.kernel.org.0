Return-Path: <dmaengine+bounces-8709-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMtEHgH1gmn6fgMAu9opvQ
	(envelope-from <dmaengine+bounces-8709-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 08:28:01 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2147FE2B25
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 08:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49BED3036D66
	for <lists+dmaengine@lfdr.de>; Wed,  4 Feb 2026 07:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD0A38E11F;
	Wed,  4 Feb 2026 07:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="eMXsKDoV"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020081.outbound.protection.outlook.com [52.101.228.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825A238BF6F;
	Wed,  4 Feb 2026 07:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770190073; cv=fail; b=iMWckv6/B7ZnibE6Mqg7F9M/AkX0SRCRD9C8ZcFhXIZl+D1kMJi2EjFoc6zmD3zyIltkhgF9xw+7Y15NKORjQVgcI/1M877q8fDb7WAuYI/fsz5UK/uRGi1cZSIOHrQpRZzrHfrFQ2Jf22/xWZM2a14mehr/uGW/XIXHXWLw0vQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770190073; c=relaxed/simple;
	bh=mAs8E2Y6MRIDhR+qpHCBH8/uzCcHONM8lsy6dFr5vVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rE26m61uucuxfIBE70PAHG8pnwSGkwBiEXV4ZxMpdcxcQThQSbYl9vr7tSSrhvtPplfPbqFG0Gc3jPm3qmh90z04xBXQiUxKTNETTc64lktepN7Qo4EPynIejNYjOZmn0ENYs7zjoYWyb3mpFdNbMgAOPtcP7aL1VjAtCVcUoBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=eMXsKDoV; arc=fail smtp.client-ip=52.101.228.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fRm/ps6qwtZBFg+QFJK4LeD9q4PCIkog7KCGZsfTU/8PNrCKirrpoKbL/Svv/Vl405ewY8jas3wuGi0y2ra9VkW2WVg3i9AuYGmF2WSOxRi4BdAdPi/itIdDgLGTw0MoLHECgUDGEmUwSJ9UkaQqkIX1bVG2xr7ML12TJF6EUBJfK9ym7m3j7Z/JUUA54SxCalNeOp/LxLgEfegmMsHRhByuaQ+UWysi2IDhr51sF05xgWrVQn2ITv3VlLO56EXRVAFv+3h89UPI/2A5c6/w7shjN+8CZcglHFfynkakk2qEpaDZ2TrcyaizpvgMQ62IdNSKaSjDbv6rKMxQxi84dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8LpKypK364etiRHbMDCYDPdwZFEO7lahXTDmV2KnYk=;
 b=fD8EdAw64IZ4ib4gOzULJLiRbcDw3qyS8fOuuk8o+YuGrlFENdARPO80VspjhSmXIK/K+fHXQKGJYstDsw868Fwpfu21t9nO1M+yPynBOwYx1PlN5GA/21hZEA6VQldgkG1a2DBWQ5fv+3DipA7JmltxEkyjN/rSba0doZH29VjktfBqeRsRHW55VoGRgv7GxqDfegHJEWE85M/LQ9Y7DbN45YYA7poSYtR2jCAi8yIM3d2EsGXZJSDrD1hzKDNuIVZE58t86dj/WuDMMXy7XIG6IhPPF/1KG02/XgSk2u6OJNesEM4tDBOy+CHO0DPLI0L+WMhd8a2PJOXqJD6DRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8LpKypK364etiRHbMDCYDPdwZFEO7lahXTDmV2KnYk=;
 b=eMXsKDoVPxC46WAeTHl3HRFmM0VXlFOHo28CbvUvoLmVyBgiPU5Db4az/z3peeudbB4G16hhsiSvowS+1BMlClw2L3KRZ57NcMGGnFKClY5nDG67oM5QubgyCpKSzKUbl5ltkZRwrVJ2GYJ3nlfROn2mHh4OHCqlYgDvnleyKaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS3P286MB3289.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 07:27:49 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 07:27:48 +0000
Date: Wed, 4 Feb 2026 16:27:46 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: vkoul@kernel.org, mani@kernel.org, jingoohan1@gmail.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] dmaengine: dw-edma, PCI: dwc: Enable remote use
 of integrated DesignWare eDMA
Message-ID: <3wtr4dllqg2ijbzwb4eklmcwwuzgt4my4bdcw2ivslgj3aoix4@kckvh7fpna6y>
References: <20260127033420.3460579-1-den@valinux.co.jp>
 <h3uhcd426u32lmn4ajjcrclabuptiy3d4lmtdbwhtu5ca2dv2s@co5piltmkhx6>
 <aYDX2Y0n8lD/iUcJ@lizhi-Precision-Tower-5810>
 <cujofbyvnhwaqpto5pjyxdl3gosat2frixuyhic6tr6zf32rzs@rvtfrcueqq2h>
 <aYIvyvHR8s//8STf@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aYIvyvHR8s//8STf@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCPR01CA0133.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS3P286MB3289:EE_
X-MS-Office365-Filtering-Correlation-Id: ebac37f8-ff5c-4d9e-8aa6-08de63bee5da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mmk3Y3p2QXBDaWFrM2tEeWFMdmswQisrQkwwRUtETlRSTDRPSk9IWEpCZzVl?=
 =?utf-8?B?REwyWWpyaThzSDY4Rm80ZU4zWDZjL3cvL0NxWFJseG1EOFdmK21WN0RmTm5S?=
 =?utf-8?B?MHhJa21wVmFRMUNxS2xRS05JaGh2U1Q1YnR3b2xGTmNNV3VleVhITGozWCtH?=
 =?utf-8?B?bnRNSHM1NUNvS0pvb1lGV0V1NHk5YVFtckNDT2RUNW5RRlNlYWV3WCtlVERK?=
 =?utf-8?B?Wm1USmROSDJCU1NWS1plOVZ6LytoVUh4L2RUb1FzTXBYZTNlcHFPSGZwVk4z?=
 =?utf-8?B?MmR4OTRYeXR2ZnRRTEZzanBUYlJEZG9aWXljamhDZmJIVmhheXpUOW91cVIr?=
 =?utf-8?B?M3JIcjhLaTFvRjNUYkx5dFlRcTNhQXB4QUZyQ1FGcDVmVm9NNkNYc1I1aDNP?=
 =?utf-8?B?M0h5bDJLTW1UVS9LLzJ5ZWhEMURzT1YxbTB4dWdzL0dlSXByanU2bjdqNGJ3?=
 =?utf-8?B?REZrUW5tWmVpUVVGSFdBc1I0bDc5NVNmTExaRytBQjB0VzNuUVQ0TUgzNjBy?=
 =?utf-8?B?bVNqWGhYS0lPYU9vSlIxVm5UQjNNd0toRDRFOU16R2JMV2hOeHhXb2sxQzBs?=
 =?utf-8?B?US9OS2d0STFibEdqMjRLSk5OSWM4UFF3RkNEci9QMkNXRmRZd2wvVG5vQ1BU?=
 =?utf-8?B?RzZXbkFWZUdCcGRIT3BmbnVIRzFaK1plQ1lDUW92cDRFRHdISFlBcVVTUVBa?=
 =?utf-8?B?d1hBYkRHQWNLUFJ5a2VNU0Y3MFN5UHMrN2lsbDFkVzlDTU10aUJrVG4wR2dB?=
 =?utf-8?B?KzE5WUU3QjdhMFJsRjB0M0g2T0w5aXRZbGh6ZE1VUUhDV1REUEwzUHNLb20x?=
 =?utf-8?B?M0dBQTZSNnFVWUZhVkJ2Ykh6UjVtM20vRHIwT1NpSFg5L1dIWHZETHN6aWF2?=
 =?utf-8?B?ZU0wOFlkSk5lMWhSZzhzckhzQm5namlpeVlWb0NRSGdoTFpVWW44cHFNVkJx?=
 =?utf-8?B?dnF5OUlFeFRkYStDL0poc1BoZEdZTHAwejV0eWI3WlNSOEo2M3Bvc3V4Yld4?=
 =?utf-8?B?Q1U4ejIrZ2hQTjVpeCtCUDBvRUJEcEh1MnJYZjByNlV6SHoyQTNrQ0VmQW1m?=
 =?utf-8?B?OG1kczV5NTdRNytjTFdiZjF1dXhNZllNQnhkQjlydTNHMXF4RlVUNU5qNmVu?=
 =?utf-8?B?dTJZeWFSR2x5Z21DNkJlSHNzQnpoSCtpZ1ZZSjRhT1FrR0ZwYUc5NWdsYVR4?=
 =?utf-8?B?QithS0wvMWVJZElHZStYTW1WbTZCOHZtUmhLd3M4M1NlRTF0R2lMOWk5eENs?=
 =?utf-8?B?OHZuWGpPYW5UMVVaaFBqYXovampQWWVOYkc4L3J4RFhPZEVxTjd3UnNpdTE2?=
 =?utf-8?B?NTJkQmwyMGUzRENJdUpra1ltQ1haOVpuS3UrOGUvSDRHN3Y5UWRYMjFDSmZS?=
 =?utf-8?B?UnFNZldzcmhCSHFrV2F1Q0o5U0lsWkhlSkpSM0Q2bkRWcW5UNDdkL3g0M2Jx?=
 =?utf-8?B?U0k3N011d2FpTGNBVXdxbkNNNGJLSUZnaTF6SklCb1YvYmp3ZFZIVklaR05T?=
 =?utf-8?B?YVV1TFd2M3N3Y1lLdDNnTzVjTnJiZ21mU0pvdTV5N0E5aHg2SE1leGxqRC9j?=
 =?utf-8?B?MHg0V25KaENENGd4NWhHcGdDZlBrZC83NWpLVTZoUG5sZjZQdkVZMjJmRWVs?=
 =?utf-8?B?Z01xZ2VsaWU4REtITlNqc2t5M293d3NjcTVJckZ3elh4MTZ3Wmd6NmxTQ1hW?=
 =?utf-8?B?elZ5SXJuYXo0ZlpIaVpGeSt4Z01salJRN09Tbkh4RlVWT2o4eWUrSWZCSHZl?=
 =?utf-8?B?VFRHZUpEZVN2dStraVNpMTM0WkV2Qzd0bm5ZV3U0dDZxVlJFRnNSQUZpY0h4?=
 =?utf-8?B?QnREMTZJa2JtS1owTHRqNUlGaFJrTHJwdkVvOXgwNXdLQzJ0Nnh5VW82RjNO?=
 =?utf-8?B?M3d1bGhYK2dYZHR1T2JJbmF0U2pPU0Z4SlJKNDhpVmF0RUdpWHJ0T0pETzFo?=
 =?utf-8?B?V0NQUURxb3loV2xjL3pwbjdCRi9leCtqQ01nTzJxZE5QUExwOVNGR3EyL0RY?=
 =?utf-8?B?ZCt1cURWQlBWWkVOZ1NaR3lES0EyNXZMdVNic1pBTlB6RlFjNzQ5VHNBUFg0?=
 =?utf-8?B?YzBOaHpHaTZMU2pJR3ZUdTRJSjB1OWR6cDJPMTRDYnNRYWlvVHZ5NTQxMjdk?=
 =?utf-8?Q?mq0M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M043bkVyL0lBLzdyZnBzWnF5NVdCZjBPVlRmRkQ2ZWxnd1M5TVNGd3hwaVBS?=
 =?utf-8?B?eDQ0dU9FYXduaFVlVFpWYWxHUTZCNkEwVWFmMExkSGV3cXBmTFZzVk96bHp0?=
 =?utf-8?B?VFFLWmZmMlMrZXRjYmtQSDJpT3VoV0dhRHNEemhyOVd4dXhUOWlGQTRiU08r?=
 =?utf-8?B?NmUwdVdDMUMwTjM3bGFCanBOeFIzbXE4R0I1MWtVK2FPYlhGT0puNjN4ZkZX?=
 =?utf-8?B?OUlNWjE2M0xmK2gyaGJDOTJqcy9yY1l2QTdlMWN0dHBrWlg0eGRJSUtGM21H?=
 =?utf-8?B?ZERVZnpXWnU5SzhJekNOTDU1bG5KaVdxQjJDVkpseXRXbTBEaGh4T2lQaWdk?=
 =?utf-8?B?QTFzcTZwb0RyczdUTkt6VHpzaGJWVnhZY3VWZlUvbVBVOFJGRTgvWkhHQmIy?=
 =?utf-8?B?emZPenRIVzJISmtydWF1RllCT00xVFlGdDZQZk1IOE84azd2dFZUMXhPSlU5?=
 =?utf-8?B?T21iOWQ4bGM5UGxMdlBQUFJUb0JwbWFPTnhZc1dJaS9DNDlQV2JQOWFqSVFk?=
 =?utf-8?B?eFpaajRPekx1dzV0ZEtFYlBWY1VrbW1FOFRLQmNFSWNTL1lVTGYxN1Q0K0x3?=
 =?utf-8?B?SElqUG81ZjY4OHgrOHUrRTBSY2htNWNaU1pnY0VCZFlhVEZvamxLYk1JVllO?=
 =?utf-8?B?TXFNS2tVRGdQZXJ3TGdWVENPdzlOR0JlcDJBbERSd2VmcE81MWVEQURvMlN6?=
 =?utf-8?B?elo4NTY5MTNnS2UveHMxYjJ6ODMrandtZkZOeDV0eU03bG5vM1NFNm8zdGNh?=
 =?utf-8?B?bjdtdi95b2h6Uks4aGdRQVNsYk9ERWMxOUNwZ09HWDIxTXZNbWVtWVN1WGxy?=
 =?utf-8?B?Q1FUc2RZalp3eDdHdDYyRnJQZW90MzN3dDlWejZPd29kZ091cllkSTV5Yk4x?=
 =?utf-8?B?eHpFdWVsY0NDQ3N1ZVJ3VCtuZElVYTNYbDJ5MjJNSGc2Z1NXb1craUJNZzky?=
 =?utf-8?B?SVNXV3NYNE5rVktnK2Z1V0NjUkl0RGZuWEQ5UWNaZWxMTFh1THZSNW1GU284?=
 =?utf-8?B?bVNIYXhZNEg1TTZIUmdsaDd6MkhFK01PNkZhKzk0OUdMZUNhdzQxMlFwWlBF?=
 =?utf-8?B?aFRXVDgwZ0pWS2FjQlQ2YTJTYkhjQ1BOZW94cTJvNEVNQjg5VURJZ0orWG4y?=
 =?utf-8?B?WGFkVncwTGFkaWhqVExtdEhycEhSaTZFT3pzSS83ZkdyR3Q1R1N6MGJHUWVB?=
 =?utf-8?B?L1ZCQUcrTFRndmRLYUc5L0pncjNlWk9vMDNjSGprZndqUjhYLytBMjd6Vk9t?=
 =?utf-8?B?MTJzNTZWOTdydEh6UmR2TFdWUUxYb3ZkeUhxcWFFSnhieXhkWWNvL0Nra1cz?=
 =?utf-8?B?SktEeWhHcTc2Qyt3aFVoQnI1a29OU3Zzbzk3T3VJeUlrUkRkVGRzdjV1T0do?=
 =?utf-8?B?by82bXNFdDlqL0NCWUJJYmdzMjFsMHJab3F2VGg0K2Z2V2xFbTZ0V0IrSTcw?=
 =?utf-8?B?ckVUZjR4SFdtV29FT3kwSFo4V09aM0JmTDM3cjFsVWcyTlhERENyYVVuVElS?=
 =?utf-8?B?dWtUa2x0NEw2RGk4ZzlqZTYvRzRsVFdSK1l2a3JFZldybW4wYVBDdi9SKzZZ?=
 =?utf-8?B?RFpDRHBWbTN2T2tKUHRmc016eGNacHNUSWhOQXZVby9xSTlaY1hVSEZmQ09M?=
 =?utf-8?B?RDR2RFJzRVpkWWk5ZE81MXFsc2ZKeXJSNmttWW8rTVZrdzA0QzVuNVVmS01p?=
 =?utf-8?B?b01ydERiZFpKZ0VDYVVrZ25JVm1SSXozZmxDbkRCU3VEOTlVY2N6dWNjVkdE?=
 =?utf-8?B?MklTeW5xVVVwRXZOKzFhSUcvZ0tGZ09CYnpURFRwUEk1aXZEcDR5VHppSTJm?=
 =?utf-8?B?RE8wQ1JySWhpTmpteStUK3RnWko0cjg3cmY3MUs1MlhPUDNtcXkxUXpQZWxa?=
 =?utf-8?B?aWV4citBUWh5bS9VNDFaVlNCWXNwZVlSdHNEN0sxZDhseVZuYm9OaXJkM3B4?=
 =?utf-8?B?RFJuMGFOZXVHU1pxS3dZWnQ3REllS3Brd29GZzArR2lRRWE5clFhM3prbDJ6?=
 =?utf-8?B?M1lpaEFQeXAySk9PMEwzK2p1cGFhOXAreCtCejRheCtXaTRnb25nWjBsZFRZ?=
 =?utf-8?B?Q2REd3pkbnUrb2NITXpQd3MvN0xSblp1VWYwMGQvWE1iSVFrZVFCVUhHQjd2?=
 =?utf-8?B?c2I4MHR4R0JiY241dVlTMEZPY0hxc3lYSkd1NHhwU3BUZWNPQy9MZU5COWlE?=
 =?utf-8?B?RE56MWwxWnVVK0ZHZUhBTzNoQ2pUeDk3UGxuRWNhVUxJS05LVWhWS0xQckNR?=
 =?utf-8?B?eC80TFRvczhqcHIyQ3ZTek1uTlBYVG9qenRPMG80Tmc5S0oxeUovK2VFdDJp?=
 =?utf-8?B?bHVVV21VUlVDa2VQZDNnejY1dmxyUFFxZ204N09LS0xNVUxPQmdTVWExckMx?=
 =?utf-8?Q?qpPljqG2WS4Vt28WiDvkpCQcn61LYt2hU9axC?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ebac37f8-ff5c-4d9e-8aa6-08de63bee5da
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 07:27:48.5891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4zbQr//vzHcNA4bXh5OilkQfVTiw4cGdEJJUBFDpt+foqBS7YAZMu3t08SVkTbnhYzvcNtEG4k+WXm/oQv4MYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB3289
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8709-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2147FE2B25
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 12:26:34PM -0500, Frank Li wrote:
> On Tue, Feb 03, 2026 at 10:59:10AM +0900, Koichiro Den wrote:
> > On Mon, Feb 02, 2026 at 11:59:05AM -0500, Frank Li wrote:
> > > On Sun, Feb 01, 2026 at 11:32:23AM +0900, Koichiro Den wrote:
> > > > On Tue, Jan 27, 2026 at 12:34:13PM +0900, Koichiro Den wrote:
> > > > > Hi,
> > > > >
> > > > > Per Frank Li's suggestion [1], this revision combines the previously posted
> > > > > PCI/dwc helper series and the dmaengine/dw-edma series into a single
> > > > > 7-patch set. This series therefore supersedes the two earlier postings:
> > > > >
> > > > >   - [PATCH 0/5] dmaengine: dw-edma: Add helpers for remote eDMA use scenarios
> > > > >     https://lore.kernel.org/dmaengine/20260126073652.3293564-1-den@valinux.co.jp/
> > > > >   - [PATCH 0/2] PCI: dwc: Expose integrated DesignWare eDMA windows
> > > > >     https://lore.kernel.org/linux-pci/20260126071550.3233631-1-den@valinux.co.jp/
> > > > >
> > > > > [1] https://lore.kernel.org/linux-pci/aXeoxxG+9cFML1sx@lizhi-Precision-Tower-5810/
> > > > >
> > > > > Some DesignWare PCIe endpoint platforms integrate a DesignWare eDMA
> > > > > instance alongside the PCIe controller. In remote eDMA use cases, the host
> > > > > needs access to the eDMA register block and the per-channel linked-list
> > > > > (LL) regions via PCIe BARs, while the endpoint may still boot with a
> > > > > standard EP configuration (and may also use dw-edma locally).
> > > > >
> > > > > This series provides the following building blocks:
> > > > >
> > > > >   * dmaengine: Add an optional dma_slave_caps.hw_id so DMA providers can expose
> > > > >     a provider-defined hardware channel identifier to clients, and report it
> > > > >     from dw-edma. This allows users to correlate a DMA channel with
> > > > >     hardware-specific resources such as per-channel LL regions.
> > > > >
> > > > >   * dmaengine/dw-edma: Add features useful for remote-controlled EP eDMA usage:
> > > > >       - per-channel interrupt routing control (configured via dmaengine_slave_config(),
> > > > >         passing a small dw-edma-specific structure through
> > > > >         dma_slave_config.peripheral_config / dma_slave_config.peripheral_size),
> > > > >       - optional completion polling when local IRQ handling is disabled, and
> > > > >       - notify-only channels for cases where the local side needs interrupt
> > > > > 	notification without cookie-based accounting (i.e. its peer
> > > > > 	prepares and submits the descriptors), useful when host-to-endpoint
> > > > > 	interrupt delivery is difficult or unavailable without it.
> > > > >
> > > > >   * PCI: dwc: Add query-only helper APIs to expose resources of an integrated
> > > > >     DesignWare eDMA instance:
> > > > >       - the physical base/size of the eDMA register window, and
> > > > >       - the per-channel LL region base/size, keyed by transfer direction and
> > > > >         the hardware channel identifier (hw_id).
> > > > >
> > > > > The first real user will likely be the DesignWare backend in the NTB transport work:
> > > > >
> > > > >   [RFC PATCH v4 25/38] NTB: hw: Add remote eDMA backend registry and DesignWare backend
> > > > >   https://lore.kernel.org/linux-pci/20260118135440.1958279-26-den@valinux.co.jp/
> > > > >
> > > > >     (Note: the implementation in this series has been updated since that
> > > > >     RFC v4, so the RFC series will also need some adjustments. I have an
> > > > >     updated RFC series locally and can post an RFC v5 if that would help
> > > > >     review/testing.)
> > > > >
> > > > > Apply/merge notes:
> > > > >   - Patches 1-5 apply cleanly on dmaengine.git next.
> > > > >   - Patches 6-7 apply cleanly on pci.git controller/dwc.
> > > > >
> > > > > Changes in v2:
> > > > >   - Combine the two previously posted series into a single set (per Frank's
> > > > >     suggestion). Order dmaengine/dw-edma patches first so hw_id support
> > > > >     lands before the PCI LL-region helper, which assumes
> > > > >     dma_slave_caps.hw_id availability.
> > > > >
> > > > > Thanks for reviewing,
> > > > >
> > > > >
> > > > > Koichiro Den (7):
> > > > >   dmaengine: Add hw_id to dma_slave_caps
> > > > >   dmaengine: dw-edma: Report channel hw_id in dma_slave_caps
> > > > >   dmaengine: dw-edma: Add per-channel interrupt routing control
> > > > >   dmaengine: dw-edma: Poll completion when local IRQ handling is
> > > > >     disabled
> > > > >   dmaengine: dw-edma: Add notify-only channels support
> > > > >   PCI: dwc: Add helper to query integrated dw-edma register window
> > > > >   PCI: dwc: Add helper to query integrated dw-edma linked-list region
> > > >
> > > >
> > > > Hi Mani, Vinod (and others),
> > > >
> > > > I'd appreciate your thoughts on the overall design of patches 3–5/7 when
> > > > you have a moment.
> > > >
> > > >   - [PATCH v2 3/7] dmaengine: dw-edma: Add per-channel interrupt routing control
> > > >     https://lore.kernel.org/dmaengine/20260127033420.3460579-4-den@valinux.co.jp/
> > > >   - [PATCH v2 4/7] dmaengine: dw-edma: Poll completion when local IRQ handling is disabled
> > > >     https://lore.kernel.org/dmaengine/20260127033420.3460579-5-den@valinux.co.jp/
> > > >   - [PATCH v2 5/7] dmaengine: dw-edma: Add notify-only channels support
> > > >     https://lore.kernel.org/dmaengine/20260127033420.3460579-6-den@valinux.co.jp/
> > > >
> > > > My cover letter might have been too terse, so let me add a bit more context
> > > > and two questions at the end.
> > > >
> > > > (Frank already provided helpful feedback on v1/RFC for Patch 3/7. Thanks, Frank.)
> > > >
> > > >
> > > > Motivation for these three patches
> > > > ----------------------------------
> > > >
> > > >   For remote use of a DMA channel (i.e. the host drives a channel that
> > > >   resides in the endpoint (EP)):
> > > >
> > > >   * The EP initializes its DMA channels during the normal SoC glue
> > > >     driver probe.
> > > >   * It obtains a dma_chan to delegate to the host via the standard
> > > >     dma_request_channel().
> > > >   * It exposes the underlying HW resources to the host ("delegation").
> > > >   * The host also acquires a channel via the standard
> > > >     dma_request_channel(). The underlying HW resource is the same as on the
> > > >     EP side, but it's driven remotely from the host.
> > > >
> > > >   and I'm targeting two operating modes:
> > > >
> > > >   1). Standard use of the remote channel
> > > >
> > > >     * The host submits a transaction and handles its completion, just
> > > >       like a local dmaengine client would. Under the hood, the HW channel
> > > >       resides in the remote EP.
> > > >     * In this scenario, we need to ensure:
> > > >       (a). completion interrupts are delivered only to the host. Or,
> > > >       (b). even if (a) is not possible (i.e. the EP also gets interrupted),
> > > >            the EP must not acknowledge/clear the interrupt status in a way
> > > >            that would race with host.
> > > >
> > > >                                   dmaengine_submit()
> > > >                                           :
> > > >                                           v
> > > >        +----------+                 +----------+
> > > >        | dma_chan |--(delegate)--->: dma_chan :
> > > >        +----------+                 +----------+
> > > >       EP (delegator)              Host (delegatee)
> > > >                                           ^
> > > >                                           :
> > > >                                 completion interrupt
> > > >
> > > >   2). Notify-only channel
> > > >
> > > >     * The host submits a transaction, and the EP gets the interrupt
> > > >       and runs any registered callbacks.
> > > >     * In this scenario, we need to ensure:
> > > >       (a). completion interrupts are delivered only to the EP. Or,
> > > >       (b). even if (a) is not possible (i.e. the host also gets
> > > >            interrupted), the host must not acknowledge/clear the interrupt
> > > >            status in a way that would race with the EP.
> > > >       (c). repeated dmaengine_submit() calls must not get stuck, even
> > > >            though it cannot rely on interrupt-driven transaction status
> > > >            management.
> > >
> > > According to RM:
> > >
> > > WR_DONE_INT_STATUS
> > > Done Interrupt Status. The DMA write channel has successfully completed the DMA transfer. For
> > > more information, see "Interrupts and Error Handling". Each bit corresponds to a DMA channel. Bit
> > > [0] corresponds to channel 0.
> > > - Enabling: For more information, see "Interrupts and Error Handling".
> > > - Masking: The DMA write interrupt Mask register has no effect on this register.
> > > - Clearing: You must write a 1'b1 to the corresponding channel bit in the DMA write interrupt Clear register
> > > to clear this interrupt bit.
> > >
> > > Note: You can write to this register to emulate interrupt generation, during software or hardware testing. A
> > > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > write to the address triggers an interrupt, but the DMA does not set the Done or Abort bits in this register.
> > >
> > >
> > > So you just need write this register to trigger a fake irq. needn't do
> > > data transfer.
> >
> > Thanks for the comment.
> >
> > One concern I have with using the fake interrupt mechanism is that it is
> > effectively channel-less, while the only documented acknowledgment path is
> > via {WR,RD}_DONE_INT_CLEAR[x], which is strictly channel-based. The RM does
> > not describe how a channel-less, emulated interrupt is associated with (or
> > cleared by) a specific channel's INT_CLEAR bit.
> 
> According to spec, it should only generate a irq, but no bit set at status.
> so needn't clean.
> 
> >
> > Because of that, I don't think there is a spec-backed guarantee that
> > writing INT_CLEAR for an arbitrary (even if reserved) channel will reliably
> > clear a fake interrupt, though I might be missing something. In the very
> > first RFC v1 series [1], I ended up writing 1 to all enabled channels
> > simply as the most defensive approach. However, that clearly does not
> > compose well once the same eDMA instance is used for real data transfers,
> > since it risks clearing real completion events.
> 
> Transfer a dummy data is not big issue. Only have to write at least 2
> register to finish a data transfer to trigger remote doorbell.
> 
> If write INT_STATUS work, which will most likely push doorbell. I have not
> did test, dose write INT_STATUS work?

In the RM, WR_DONE_INT_CLEAR has the description:

    Done Interrupt Clear. You must write a 1'b1 to clear the
    corresponding bit in the Done interrupt status field of the
    DMA write interrupt status register. Each bit corresponds to a
    DMA channel. Bit [0] corresponds to channel 0.
    Note: Reading from this self-clearing register field always
    returns a '0'.

Based on this, I originally assumed that writing a 1 to at least one
channel bit was required. However, after reading your comment, I tested
this on R-Car S4 Spider (eDMA) and verified that writing all 0s to
INT_CLEAR is sufficient to deassert a raised fake irq. This means the fake
irq can be acked without interfering with ongoing real DMA transfers on any
channel.

For HDMA, I do not currently have access to suitable hardware, so I have
not been able to validate the same behavior. I guess something like this
might work:

    SET_BOTH_CH_32(dw, 0, int_clear, 0) // channel 0 chosen arbitrarily

Anyway, based on the above, I have prepared v3 of the series and also
locally updated my RFC series ("[RFC PATCH v4 00/38] NTB transport backed
by PCI EP embedded DMA") accordingly. This fake irq approach has been
working well in my testing, so I plan to send v3 shortly.

Thanks for the review, it helped a lot,
Koichiro

> 
> Frank
> 
> >
> > What's your view on this?
> >
> > [1] https://lore.kernel.org/all/20251023071916.901355-16-den@valinux.co.jp/
> >
> > Thanks again for taking a close look at this.
> >
> > Koichiro
> >
> > >
> > > Frank
> > >
> > > >       (d). callback can be registered for the dma_chan on the EP.
> > > >
> > > >                                   dmaengine_submit()
> > > >                                           :
> > > >                                           v
> > > >        +----------+                 +----------+
> > > >        | dma_chan |--(delegate)--->: dma_chan :
> > > >        +----------+                 +----------+
> > > >       EP (delegator)              Host (delegatee)
> > > >              ^
> > > >              :
> > > >       completion interrupt
> > > >
> > > >
> > > >   Patch mapping:
> > > >     - (a)(b) are addressed by [PATCH v2 3/7].
> > > >     - (c) is addressed by [PATCH v2 4/7].
> > > >     - (d) is addressed by [PATCH v2 5/7].
> > > >
> > > >
> > > > Questions
> > > > ---------
> > > >
> > > >   1. Are these two use cases (1) and (2) acceptable?
> > > >   2. To support (1) and (2), is the current implementation direction acceptable?
> > > >      Or should this be generalized into a dmaengine API rather than being a
> > > >      dw-edma-core-specific extension?
> > > >
> > > >
> > > > Any feedback would be appreciated.
> > > >
> > > > Kind regards,
> > > > Koichiro
> > > >
> > > >
> > > > >
> > > > >  MAINTAINERS                                  |   2 +-
> > > > >  drivers/dma/dmaengine.c                      |   1 +
> > > > >  drivers/dma/dw-edma/dw-edma-core.c           | 167 +++++++++++++++++--
> > > > >  drivers/dma/dw-edma/dw-edma-core.h           |  21 +++
> > > > >  drivers/dma/dw-edma/dw-edma-v0-core.c        |  26 ++-
> > > > >  drivers/pci/controller/dwc/pcie-designware.c |  74 ++++++++
> > > > >  drivers/pci/controller/dwc/pcie-designware.h |   2 +
> > > > >  include/linux/dma/edma.h                     |  57 +++++++
> > > > >  include/linux/dmaengine.h                    |   2 +
> > > > >  include/linux/pcie-dwc-edma.h                |  72 ++++++++
> > > > >  10 files changed, 398 insertions(+), 26 deletions(-)
> > > > >  create mode 100644 include/linux/pcie-dwc-edma.h
> > > > >
> > > > > --
> > > > > 2.51.0
> > > > >


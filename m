Return-Path: <dmaengine+bounces-8789-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHhNII8khmlSKAQAu9opvQ
	(envelope-from <dmaengine+bounces-8789-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 18:27:43 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE54100F50
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 18:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 081EA303388C
	for <lists+dmaengine@lfdr.de>; Fri,  6 Feb 2026 17:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9B440B6D4;
	Fri,  6 Feb 2026 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="EoSgBFiz"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021088.outbound.protection.outlook.com [40.107.74.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C153EFD0F;
	Fri,  6 Feb 2026 17:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398819; cv=fail; b=XAp2cSvA7WWe8CJHIMNwWNWUW/CA/0NGQWnMxGQM3NOoQ3OIlk3OvjkL2BDpDb4BMzImG/H5zQs+/wV+ITkx6pYoXiG5Ma8Q+Nlrc1Nq85dVqeC/Hi8trWy6sqVAl+xygrMZ7mYPrlNxChSYcRonRdPxLvOQ6UoWsjjZ2chSTQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398819; c=relaxed/simple;
	bh=5ISnTmFPau8kCE2qDS05W2k68KDC3NHrh+bzC1yCMeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O1w7PSW0K9mTwa5qG2UWN0WwM9s6dT5YyDZADmQiXIzofZsxidXAc7xDPOjblsnUsTBLzBbS9IpwqjWKhgBFVvtqmzi+kpvYxnIos4c2uhaOTQg+JkLXBouFZwIb/hPa9WxqiIe7ckvigVP9vJGP/7j80I39UnTqxG40fCtqHCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=EoSgBFiz; arc=fail smtp.client-ip=40.107.74.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VdCUX4F950NIEORRztAfgjishDIy5RpHl0GoGbeITIfdT5700vXoeYP0Nbpvgf/o+JA9Mk6nQ8gvuVUGNKRDIE0hgFKFT2eE/INDTptfUnQ9fyRGGNUcIVvOUjYyZQ8FwRA5DaiuTdpbzXl67VKBzKOVH97Yp/rwnQquX4KAjZccZWrw10rJUZZh5eGpTn9gUlv/OQ3idQLK8YemmL7+iCrv+CgIdOvM3dPG3ntxti76ku9JodmW/vKr5AWejhHUErP6A+jrJz1h0xQS233EVwYNzZg8Hftv2wlH194zjpnmANUDuYpOf7KJZbIMK1c+5UxvC/uOl3fUDiWdJUoj9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuOR9Ml4lxeSjus2aDisIXVXdHENVICOe5j68gTiTFo=;
 b=YN8Nr2ZnxRBd11vW+Bl1VfCS2NjSPLZ+/NDpF0i7B1OYtvzLtaYXos2Me/tt1aWj6aYNPOistnPfFIz6o/TNDXDiT63tFO2UUVS7yU9hTfhxCrGVbI/u0WuQ3j3Jr63kKEM0YD5QrSMtP2bCoTqYHwofhk0y1OP7gC17mgRbno4CAcN0gE2gOVMzVkA6bBVInG4Ysynpcn6aLa+ZLjdIC0gzj7+H6NQCLYqOClV84NRkZ+m+KOzc+aOoHk6ryzERsvE7JbWgIEJNI6Y+fAkJdRjrGXCQ7TzNfkuIEkNuESwoIY/Wnjp8ayVivYghxUTFEutQEOacfnse3fLkLDzHsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuOR9Ml4lxeSjus2aDisIXVXdHENVICOe5j68gTiTFo=;
 b=EoSgBFiz2iHUG6nEMtf2JdeO72Os5J4rBQY1oFbZNTozrJ/vKU2Z+Lb4Yf9GH3UF2SIfFhU4ICKcka+i6ZDWlXkL0RvETk4y3qH54gH2nMqZWAZfpKx91hnW10fAMYzeUHz5KiXswPUpK0CaklEGEUMeq+0yIPq5d5DqkHjWdY8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB5571.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1f1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 17:26:56 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 17:26:56 +0000
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
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/9] dmaengine: dw-edma: Export per-channel IRQ and doorbell register offset
Date: Sat,  7 Feb 2026 02:26:40 +0900
Message-ID: <20260206172646.1556847-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260206172646.1556847-1-den@valinux.co.jp>
References: <20260206172646.1556847-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0041.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB5571:EE_
X-MS-Office365-Filtering-Correlation-Id: a904ef6f-f22d-4f97-b509-08de65a4ed21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T6tSRtqlohxTJHR6kU/HMXVLy9EVDe5IkZopGmjkiQNBT4sy+ALWbqUohKqG?=
 =?us-ascii?Q?BlYK1xTE4EKbuuqtwgOeobvypLObh0zKT1VKzHmsgPANj8vHwv08i4sFytc7?=
 =?us-ascii?Q?4OcrjT/HoKAqHbE602vMKqR/Nt2AA1nbVOQ7C+n7YaqXdu/JCOXuXqHv4Txe?=
 =?us-ascii?Q?Y4N1AOUgqZS0xu3Pzotzx3hkm4s6D/Af1720AUfVaEZr7ZnrMiPk2EGTYSj6?=
 =?us-ascii?Q?MvVKRgoh4EnQ6P4il+oSo1zdJ37MPJ9Gr0BwL/imqu+TsFsC91KtmWsKQsw9?=
 =?us-ascii?Q?G44I3iWLNiXPuR+tY2VTkVdJFyaM3FXLgxWYpMQ6nvg4EM3lpWEGL57cZm4f?=
 =?us-ascii?Q?GFu3KuqDn0mfRySnmJhL/IbQ34gcNLHndyr3bVn1QUJ3kVnHGYAgdtiEZQLe?=
 =?us-ascii?Q?FImxZ3387eX+gOT2fFbVUqql9HcW1E4TKLCjTK7TUqm9/kK9azbb+3B9NC0f?=
 =?us-ascii?Q?t9l/yPxcn9ywGxDqxOG6tkeHIbfNm7ex5gs+IKQw0wQCo45Oiy1rkpG1HpYz?=
 =?us-ascii?Q?+bXzbjPpj9iKwuVG76ekVfJmRbEm6IcZa83+AgTar3Im20EIRkHnH1JdQdzZ?=
 =?us-ascii?Q?e7DE2MaxFkC+k7W2OKlVJm58OZgSzPKyXSv3pBCG8MMpIZf1SXsqgE57n4Fx?=
 =?us-ascii?Q?FfoAWU4Pt70lZoQc2za3NHs/VUBUBEylbKcEBtOpXYAZr30kCHfYGJgaU6bz?=
 =?us-ascii?Q?LDT8V6YoQIsivaYIvGg+uDW9Frcvdc6JtXdTvgHL/qD77SKcYO6fi/lIkonr?=
 =?us-ascii?Q?2V45Fqn8hiKct9kmM0iWQFsLJUe949g0Rqf8bmlW5IdIL2/zWKN48uR4NrfT?=
 =?us-ascii?Q?9gG/QHBsY2awy+xU65HGnQJBFJxgW5tu83IjgCOngG/zEd/we6fTBTK5iWoT?=
 =?us-ascii?Q?qFDINRTXPNYWpl1NEOpPNFM6t0Z5dAp8sLQ04mOfNoq3yFAiaepoYun1hlDT?=
 =?us-ascii?Q?2DQa/AzGVGn4vzuA/OvmSsjtapcWAW4BNOS6FnJa0Rv5ie+7OkKhmVKtGFwC?=
 =?us-ascii?Q?N6ABiI1ZJycl9cUxckhHi90cihgz+V5BEogc0sk9psxznYkm+fSZUd4mGtIE?=
 =?us-ascii?Q?RFwFytNHtP2J3XAOz6qnNac+q0QfSQHVOHruH1YoE6cI0UhBadLFqHpLzcZ9?=
 =?us-ascii?Q?qtYi/ZvMY7IHb8I74EBCvpbK1JICGxM2N7dQr/R/SpWKpEHYZ8yyuisdcTKL?=
 =?us-ascii?Q?+o15YJmlfPzAiJa7BhRmmP/xZOtbkOe3Aw+afcilqjoPEbPDUYIw09TP5I9m?=
 =?us-ascii?Q?xTKb1TguJQSqpXIizWKOLeIGDngCdVAvkas1aKU3bRoUYTgWKVuTr/SrJaBR?=
 =?us-ascii?Q?9US9Q158sNA7aPpYGhoIcj59fGT1IXSpx536nnvp2t1Bb6GqZ6jvLH3qYRrT?=
 =?us-ascii?Q?g7CKZFKihnOJLhMkSK394S9pTQ9rGk4a4GFe5/42vNXnCAocl09BvRo8EKW8?=
 =?us-ascii?Q?Yh287mOpHP8fBphV/LO/aWTYA5Dkg9WTdRodL0nmCYiwq5ZlM3FRaUo1D5nO?=
 =?us-ascii?Q?jhYVF8JjPaYW5A6rTeF/0XTKymKL60U4hHuSlN8foW8I7rZS+j2EqUyn1dbr?=
 =?us-ascii?Q?hzIO1SgfaqPuTQV4tPw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rxIRXzweRwrA1onQ1cnYgaJprDn+gUOcP2zskrRYxl2QyjauQbzl8+AoKtSP?=
 =?us-ascii?Q?0DOSoK1582K2hFXQFcLSbt3Rx/YWAptJ1WDBI/u8sCXJumVWYFzlVv8kCnaZ?=
 =?us-ascii?Q?uyCLo8u5QX6+MxfMNzYp3qWwEjiWa41gyiiP7aG3qYGGhBe3pbx8yo3+GZOw?=
 =?us-ascii?Q?mzXV4YNXTJd5o+vRFMMnwd+EMGtyWfqfzkqz11GvCaB4DvLtQFiE+jiUdLqf?=
 =?us-ascii?Q?LJztn7ds/P4BUue8j4+UWGWkLOrBWnKpVtK1aeCjT36f30o7+Cq0uM8sb1od?=
 =?us-ascii?Q?i8ifjeTGfUkQXC6uEFpJ+ZcjeTwOtisvaZCvT7H/x3AY7zG3I09Tdlt6ZzqG?=
 =?us-ascii?Q?UjRJmvq+kPeZ38K2xYCcJ5GqSn7iek+SGYOTZjWIV2AumxcsE8ZqN7ghjmdD?=
 =?us-ascii?Q?D+ugAWEIJJW4anP26hkjlcVAMi2GDYS+75JbJ5KAYpINUreQgw33IvHaCGUW?=
 =?us-ascii?Q?A61k7ynO/vTGvTM1bt2K6ARKhd80yBNLbMP5g7s1IlfhOZ9XBrK05zsFOaFR?=
 =?us-ascii?Q?qJnZXmyS6Xki9UuAlii4uA1UMC0WpbS0bnGSACPazb71PD/z73/N2zb54cCR?=
 =?us-ascii?Q?MUmvejf9J5fJypYrUrrBXFq5uTpOgvvoyDv/UPRn0HGyHNNKOI4Fv/wOneSq?=
 =?us-ascii?Q?465n//In11yJJdvE0ssl+8LzX9qoPwhheABs6WCFrKkCGxHVYcfPy031k598?=
 =?us-ascii?Q?QtTJQjZ99igcKxfAc+fPkSr58WnCCilKQPzmrL7bUPKiQuGBGl6nVwROv4Qc?=
 =?us-ascii?Q?mMEGDSyJCgj+qx7Z+6gAPKzRmbc6dKfJfSj52Y4neejHMDbQY5m1q2USlLRE?=
 =?us-ascii?Q?+SVkIW6KMWjm3/J5RqsO8f4RprA+cD4xMDEuqmwMvNvmFNkmv4SOjSZtQUQB?=
 =?us-ascii?Q?a4gVAhgzf36sKun+TIhKFLAWLzSBaGK8+P9Zt8Z1xJ5vg5GCMS79ClZHfDD0?=
 =?us-ascii?Q?kl7eMWPIizeYxWgIwtG6v5iRprAaVxNVOG9w/3mEiP6UxLgSgxbsTnM5JQeI?=
 =?us-ascii?Q?M2acpWAAqwjaPOrjWoh50+NdZLvYjIymw5Gqd9xRhj8cPc7r3s52f7BzkIRi?=
 =?us-ascii?Q?L3gk746cCMIUnA24qw7R6XwIYC1BO7GFlADGymUaU+5/cF6NPdlPQsEdI1kQ?=
 =?us-ascii?Q?zdGzNGmD4IrMTLyY+UJJoiFCu53O6h9tj8QPEWRwq1tij+zrRO8mk2qr42Re?=
 =?us-ascii?Q?qP/V01uE565J1cRgwh+WRsVycCgDmGgcOI9Vq5AIQq6StHAA21CbOXgBHqpB?=
 =?us-ascii?Q?4SB5H++jpgGKkNxhxJpYa/2uIAWzLVPNJxko95cpohS3+rPiMj9i1OotwSiy?=
 =?us-ascii?Q?fVSkEDVEhjzdl2c0lOVBOgn2rtJe834qjOnRSuPUcXaw4LoQ02+LKqgPtTdv?=
 =?us-ascii?Q?5AKRkoqdibgKnwH49aggm7/YLBpRUtWdO7YGp2GaUeKUbFA6UHDCkcCn0rua?=
 =?us-ascii?Q?xXgpsmZP+B3LNC9UL55SqnNrblXzrip78WYo5+CYrGotC8CbGV2aLdD+lDTI?=
 =?us-ascii?Q?NR73Soi/BYpjgkVJHxIDPs2F8pTA5KInPzG4J+I3lT/JWjipqL9EI2kNRf7f?=
 =?us-ascii?Q?rzECkbPJhJn/HZ/JZKWwZLCGMvXN3yK1VRMh/YrrI09sOye8cRSGXNxA1nHD?=
 =?us-ascii?Q?VFzrl1k5D4W047Wtjma6uEGI9BX6GD9sFIJJtdwFpeEgVZ7oKjBjamWqQvSU?=
 =?us-ascii?Q?VFmd9yqJFEQLUz8BWMZYnz8KiCYSAdJOP4DV8Pj6JAavXCdg+aUwfsBrveRq?=
 =?us-ascii?Q?05gSRPxqoxlzxicIH2vZpzyV0P3iuDKiV2rzomeheWtxVhF6J1qr?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a904ef6f-f22d-4f97-b509-08de65a4ed21
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 17:26:56.1083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IvvdsY6TsnEo8o5tFYu98/L0BUian5yhO+6QdaZtAib78rGuGspBoNjznxoJxVQjy7vEXMnUGwp2NYGz0ta9lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB5571
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8789-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,gmail.com,google.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CFE54100F50
X-Rspamd-Action: no action

Endpoint controller drivers may need to expose or consume eDMA-related
resources (e.g. for remote programming or doorbell/self-tests). For
that, consumers need a stable way to discover the Linux IRQ used by a
given eDMA channel/vector and a register offset suitable for interrupt
emulation.

Record each channel's IRQ-vector index and store the requested Linux IRQ
number. Add a core callback .ch_info() to provide core-specific metadata
and implement it for v0.

Export dw_edma_chan_info() so that platform drivers can retrieve:
  - per-channel device name
  - Linux IRQ number for the channel's interrupt vector
  - offset of the register used as an emulated-interrupt doorbell within
    the eDMA register window.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c    | 31 +++++++++++++++++++++++++++
 drivers/dma/dw-edma/dw-edma-core.h    | 14 ++++++++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c |  7 ++++++
 include/linux/dma/edma.h              | 20 +++++++++++++++++
 4 files changed, 72 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index dd01a9aa8ad8..147a5466e4e7 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -842,6 +842,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 		else
 			pos = wr_alloc + chan->id % rd_alloc;
 
+		chan->irq_idx = pos;
 		irq = &dw->irq[pos];
 
 		if (chan->dir == EDMA_DIR_WRITE)
@@ -947,6 +948,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 		if (irq_get_msi_desc(irq))
 			get_cached_msi_msg(irq, &dw->irq[0].msi);
 
+		dw->irq[0].irq = irq;
 		dw->nr_irqs = 1;
 	} else {
 		/* Distribute IRQs equally among all channels */
@@ -973,6 +975,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 
 			if (irq_get_msi_desc(irq))
 				get_cached_msi_msg(irq, &dw->irq[i].msi);
+			dw->irq[i].irq = irq;
 		}
 
 		dw->nr_irqs = i;
@@ -1098,6 +1101,34 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 }
 EXPORT_SYMBOL_GPL(dw_edma_remove);
 
+int dw_edma_chan_info(struct dw_edma_chip *chip, unsigned int ch_idx,
+		      struct dw_edma_chan_info *info)
+{
+	struct dw_edma *dw = chip->dw;
+	struct dw_edma_chan *chan;
+	struct dma_chan *dchan;
+	u32 ch_cnt;
+	int ret;
+
+	if (!chip || !info || !dw)
+		return -EINVAL;
+
+	ch_cnt = dw->wr_ch_cnt + dw->rd_ch_cnt;
+	if (ch_idx >= ch_cnt)
+		return -EINVAL;
+
+	chan = &dw->chan[ch_idx];
+	dchan = &chan->vc.chan;
+
+	ret = dw_edma_core_ch_info(dw, chan, info);
+	if (ret)
+		return ret;
+
+	info->irq = dw->irq[chan->irq_idx].irq;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dw_edma_chan_info);
+
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
 MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index abc97e375484..e92891ed5536 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -82,6 +82,7 @@ struct dw_edma_chan {
 	struct msi_msg			msi;
 
 	enum dw_edma_ch_irq_mode	irq_mode;
+	u32				irq_idx;
 
 	enum dw_edma_request		request;
 	enum dw_edma_status		status;
@@ -95,6 +96,7 @@ struct dw_edma_irq {
 	u32				wr_mask;
 	u32				rd_mask;
 	struct dw_edma			*dw;
+	int				irq;
 };
 
 struct dw_edma {
@@ -129,6 +131,7 @@ struct dw_edma_core_ops {
 	void (*ch_config)(struct dw_edma_chan *chan);
 	void (*debugfs_on)(struct dw_edma *dw);
 	void (*ack_selfirq)(struct dw_edma *dw);
+	void (*ch_info)(struct dw_edma_chan *chan, struct dw_edma_chan_info *info);
 };
 
 struct dw_edma_sg {
@@ -219,6 +222,17 @@ int dw_edma_core_ack_selfirq(struct dw_edma *dw)
 	return 0;
 }
 
+static inline
+int dw_edma_core_ch_info(struct dw_edma *dw, struct dw_edma_chan *chan,
+			 struct dw_edma_chan_info *info)
+{
+	if (!dw->core->ch_info)
+		return -EOPNOTSUPP;
+
+	dw->core->ch_info(chan, info);
+	return 0;
+}
+
 static inline
 bool dw_edma_core_ch_ignore_irq(struct dw_edma_chan *chan)
 {
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 68e0d088570d..9c7908a76fff 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -529,6 +529,12 @@ static void dw_edma_v0_core_ack_selfirq(struct dw_edma *dw)
 	SET_BOTH_32(dw, int_clear, 0);
 }
 
+static void dw_edma_v0_core_ch_info(struct dw_edma_chan *chan,
+				    struct dw_edma_chan_info *info)
+{
+	info->db_offset = offsetof(struct dw_edma_v0_regs, rd_int_status);
+}
+
 static const struct dw_edma_core_ops dw_edma_v0_core = {
 	.off = dw_edma_v0_core_off,
 	.ch_count = dw_edma_v0_core_ch_count,
@@ -538,6 +544,7 @@ static const struct dw_edma_core_ops dw_edma_v0_core = {
 	.ch_config = dw_edma_v0_core_ch_config,
 	.debugfs_on = dw_edma_v0_core_debugfs_on,
 	.ack_selfirq = dw_edma_v0_core_ack_selfirq,
+	.ch_info = dw_edma_v0_core_ch_info,
 };
 
 void dw_edma_v0_core_register(struct dw_edma *dw)
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 53b31a974331..9fd78dc313e5 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -129,10 +129,23 @@ struct dw_edma_chip {
 	struct dw_edma		*dw;
 };
 
+/**
+ * struct dw_edma_chan_info - DW eDMA channel metadata
+ * @irq:	Linux IRQ number used by this channel's interrupt vector
+ * @db_offset:	offset within the eDMA register window that can be used as
+ *		an interrupt-emulation doorbell for this channel
+ */
+struct dw_edma_chan_info {
+	int			irq;
+	resource_size_t		db_offset;
+};
+
 /* Export to the platform drivers */
 #if IS_REACHABLE(CONFIG_DW_EDMA)
 int dw_edma_probe(struct dw_edma_chip *chip);
 int dw_edma_remove(struct dw_edma_chip *chip);
+int dw_edma_chan_info(struct dw_edma_chip *chip, unsigned int ch_idx,
+		      struct dw_edma_chan_info *info);
 #else
 static inline int dw_edma_probe(struct dw_edma_chip *chip)
 {
@@ -143,6 +156,13 @@ static inline int dw_edma_remove(struct dw_edma_chip *chip)
 {
 	return 0;
 }
+
+static inline int dw_edma_chan_info(struct dw_edma_chip *chip,
+				    unsigned int ch_idx,
+				    struct dw_edma_chan_info *info)
+{
+	return -ENODEV;
+}
 #endif /* CONFIG_DW_EDMA */
 
 #endif /* _DW_EDMA_H */
-- 
2.51.0



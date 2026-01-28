Return-Path: <dmaengine+bounces-8563-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLWcNwFRemnk5AEAu9opvQ
	(envelope-from <dmaengine+bounces-8563-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 19:10:09 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CA62CA784B
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 19:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4257C3042DC0
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 18:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682903783A8;
	Wed, 28 Jan 2026 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jlpdDKZH"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013040.outbound.protection.outlook.com [52.101.83.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C7B37755F;
	Wed, 28 Jan 2026 18:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623568; cv=fail; b=GR1iSroEGpqU9QpucJCOIdA/xbeJTcJhg0cbbMjw3jpEVuPA3CV5wZlRFOqGzNaK0xdjuyJabhMMa0Q6s8/Rf/yZQjgczKVr3hsVX+XyvIqLKXcXx9gN+WrEuyUJ/Nadm1Nv25TAd/Jvdrk/vPHi1NRpYiqn+sLxvYcajbHJyxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623568; c=relaxed/simple;
	bh=GGybxVqDwFHeefQJ4VXNOM/LJgpNvM0KoiTvNlHzlDg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=XwDK4T0kMZmri56CN3BfnyGyU+EV3MjC131iBkakfsAHFIT9qPdWoyfw2F1CgLtOsvLSZi44rvUR0Y7zMQvloTfM4jm7TizrYN5KwOmC9hIxtS5uC/VrWGgXGUrB58i7KVGnLYrujIPi4IfRoz9pCigiHGdUgiEQx8ZE8wxSZOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jlpdDKZH; arc=fail smtp.client-ip=52.101.83.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BE/Ta5daXewyjIveGhPGFI7tAApi+RVbD+iC8otnC0IuizjvM5BwAZy7FBAF5/mjGZTzAa5BHfV+NVgtxT/fK+Ctsk34OC4hONH4HRIX5oDhlRUruudjjvh/XQwQkA9BJryCsg5//C7wIByRq4M1Mozm0OC1A9XdghgYw2ha46GGRGqlAcMC9Tu28I5rzQtBLBZEkAPpap8XKNZbX2mMlGalMkeHl/DhztKo+cTeRNNUMDqKrvKYWJRsoWV4nvwOyfeRVLuZpY/aIX7ITNo4SKu0eGSpTrXcRfptlnNALlcfWHOKnwaf+Sz9qihB5UOQz561XrVNKAEwtdSXf3ovEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/pa4I33FAqL4RoRKSe5v1LsrWdfSbAz0GychtgbwKE=;
 b=LvwxpCLHd89aNTeRtnlEdT5cdR+AXoF7ySbVrpVdBgGbmRM3/Nu3+dGp321JNsVIAF9YBgiDP1HlOZ7ovoDv6Ee/obqVEk91Cb6BbJAmhn7M58Nc7su+aJZD7NdLDapRlCJJFQd1Zuhh9iT6/2RKQDvDVGQDXJiSEOemDA5Fn1huziDghvQ6SKyRwjvHV1p8Ew5u/2amJzejFIlQh1bxZQ/8nJhX04hbmeRUYFClJh4JIfqdfnXH55y3Gj/nEhQledNnomNn5x1bvjxs5qdKHZ0S23vKGsGeUEF+8MIMw+UKFD/p8+cw7Q2UjrEidQyaT8Q9CW/Nglq6fds8f55pkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/pa4I33FAqL4RoRKSe5v1LsrWdfSbAz0GychtgbwKE=;
 b=jlpdDKZHpCfeQxcHs+qu7vT+JEdki/THkeKTOhFZC380H5yS5hegP0A2NAwzGJHOT3s//2S/WuqbW7BNDuXajbotqGDAOTE0Ciaoyhvz7e+EyMSmIBAsGKC6PEW6P6PgQh2Bwx/9sGPX5CNSNC7p3k1gvSDbXRWWzICjRplYDh0X4anrwLiDWNn/sZQSWyWBlEGKX1y69bPCXWOdFw5rcqrGiGUmIrmG9u93ep9zjYNAdDkYOoACwkIaEOYYYUVAM+1ZRV2+0RbUKUI8t/cDV1B2bpQTsYPi2LRP+F5muGOicqdqzPGcXuIQ7fWFmFr5Es46VHPrQ6YHq3Y2Czrn4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB8145.eurprd04.prod.outlook.com (2603:10a6:20b:3e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 28 Jan
 2026 18:05:58 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9520.005; Wed, 28 Jan 2026
 18:05:57 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 28 Jan 2026 13:05:26 -0500
Subject: [PATCH RFC 07/12] dmaengine: virt-dma: split vchan_tx_prep() into
 init and internal helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-dma_ll_comlib-v1-7-1b1fa2c671f9@nxp.com>
References: <20260128-dma_ll_comlib-v1-0-1b1fa2c671f9@nxp.com>
In-Reply-To: <20260128-dma_ll_comlib-v1-0-1b1fa2c671f9@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 imx@lists.linux.dev, joy.zou@nxp.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769623546; l=2942;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=GGybxVqDwFHeefQJ4VXNOM/LJgpNvM0KoiTvNlHzlDg=;
 b=UxDficT3vczAw/xw6eH1BTR7CFKYOP7cu5ukWBQaRvY8LvXU8HGL4hUVuAUTbGDIlba3tmUCh
 PRX4XEzHRlQDGRfp4/ocnZm0kXf+fSth/jMA/8QMkBEMhLLJodjygrz
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:806:20::14) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: 183494ab-3cde-4a2c-c292-08de5e97e331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEdiamlNckxhdWt0b0VTaDRpVE1RV2x5Q1NsNS9YQnV2VTVyakNjV0RHV1dv?=
 =?utf-8?B?dHJpMWZYN2ltb201M01nK2VwV2NOTkNvSkpmcjI4K0llbzhqUkJIZXRPQzY3?=
 =?utf-8?B?dWNjaHNHR0ladGFWUnVnNTlpWmJJNUpzQVZNQkEwZFA3elkrL0hOS011MXpG?=
 =?utf-8?B?ZW12MXg5SUZjM0U3SlMwRDE3ZENNNGcwNWZYM2hkYjRRSDUxcG1hY00vSjBM?=
 =?utf-8?B?N2YxQTF4SUJUakxJVlpWcU10UDVFODBsOTVaMFlCZWI3LzFrN0hlREJGTkZC?=
 =?utf-8?B?dXRQMGNrNi9UTXpOdVpTemFqampuVkZFV2U0b0ZsTlRKMXFWUCtETGRoQzRK?=
 =?utf-8?B?dnFrSXBRV1dqK3g4UmZSUHlhVkUxMmpHd1dYMWZTWWpaOFgxV1pReGI2TnRm?=
 =?utf-8?B?aTV4eURGTG95czRncThWSEV0dEI1clcvK2JxQm5Cb1FWWlAwcExxTHBUekVO?=
 =?utf-8?B?TmlwOW8zME5vVW9SVGVKd2lvdERKamhuOVRlUGkwa2FvSmhkQ0tKQyt1TkVC?=
 =?utf-8?B?U1F6d2NMU25ZNmV5U0hDMnQrdlpJVUh6QnBTYVBBTTQ1dVo3WlB0TnVYVzcw?=
 =?utf-8?B?YWVIWmt3TGJaVEhWS2JtYnd0RVVqRjd4WTkzNHMrVDFuNnlpSDhWNDJvWEdO?=
 =?utf-8?B?SDRGc1ZDbHdJNTE4bzUyR3drd2luQTVCRytmTXlRTlJqZFY4REI5SWViS0lj?=
 =?utf-8?B?MGlqQU1hMlo1MXlPSlBYN0piQnp3ZjJtb0lFSWZwRUgwSGxMcWFzbTFSSllX?=
 =?utf-8?B?cDBsV1dLRTZBUXpmL0puTG1VdzE0ekZPWFlabGNuNmMvTGFxSUdiOGJnQ0hl?=
 =?utf-8?B?TnFVcU9CVWdKMnNqOFR1ZmNkT2x5dldnVUtrdHh2dTlrQzA4VHBkQXFKeVRm?=
 =?utf-8?B?bnBZWTF4N3N1b2RVMFgyZWRlNEZrbU1LemFoNnFoRWVUN1NYVlZaSWttZVow?=
 =?utf-8?B?Q3FBdU1ZZUZuUDVkdDM4Y2JSempheFM0MjRVZkpSWDN5QWNFQkkwZEY2WHhH?=
 =?utf-8?B?NHVsWVQ3ZlNsNFAwQlRFcUNURlZzZ2dZbU5WbXh1aHcxaXN5SWNrQkNuTSt2?=
 =?utf-8?B?dk0xTTJreXlsZGQ4ZFFkd0lmWjc0c1FZazVxTEliUzFZTlZHdGpNNkxIckUy?=
 =?utf-8?B?N2RIdDlycWFFMGpXVWEycUo3UkJ4YS9OdFp2YTYvRnZoYUtiak5uSUVOVGg5?=
 =?utf-8?B?dzFPYi9sSjAwem1IdzJ5WFJuTTAyOUtTaTVodlZKSXMyYkJnOXJoQmo4VDVN?=
 =?utf-8?B?bzc3Zm1IMHltTHpoTXJwWEtJOUNyeU5jOXJFMElKK3J5SjJLRjQ4d1l1aWEy?=
 =?utf-8?B?T2xscnJZRVdyYnNLZERqKzFRQ2VWcGIrdHRzUVNhMTNMWHk0NU52SlNsUUQ0?=
 =?utf-8?B?dnhrOWRQWUpvcEVHSWs4cUR2ZndCOVozU0IyUmRPcElQV2E2R1ZoZTlVY3dw?=
 =?utf-8?B?c1k5Qmp0d0J6WU1LRUNFaC82N2hZTUdTbzU4bjQ5S2pUaVVDY3hFOTgwTWtz?=
 =?utf-8?B?N1BUa1FWQXN6NlNwUTZ1UWFENHBiSkx0WktpOFFzTnlQRmppUzUzY1cwNTBv?=
 =?utf-8?B?RVdqaDdJLzhWZlJ0anJDeHRnUVVodUFhbWdaQjJUZ0JSdG0vZzdSZXFLZE8v?=
 =?utf-8?B?NlozbHEyK3N5aGppQSt5OSt4RDdoZFFidkdxYjAwdmxQd3NBV0MwRXBQcEZC?=
 =?utf-8?B?dUdER0NVVEFYbUU1cGp4eFRBSzBmYmJZTnNJbW5BazlOK1JWYisyWFNhamF6?=
 =?utf-8?B?NmhLTGJWVGdQdUFyaWFQZWxieUUrWEFNbUhWM2VSSlVGMXM3Z3Y1Q0xiczNP?=
 =?utf-8?B?dGlSYVFqT0ZwYjlGL2QzMUl3QngxSldsZERnTjVsMlovSXFzem1RbkFlRUs1?=
 =?utf-8?B?R2I4MHZ6RitSZzB3ZmNhYXNhL2x4TXhKdXRQY0NST1pXcDMydTJHYy9SWDdJ?=
 =?utf-8?B?NUZZOElITENHeitJSmR4WUphTUVGSkFma2FHMXltU2lmSFE5bk91UUZHbUwz?=
 =?utf-8?B?Nm5sSjNYenVYOEZibnR0aFduWCtsRmhvUXE2Slo4QWxrOXhMZVRDS3czdmky?=
 =?utf-8?B?em9TUW5HeFNsN1RWZW5rcjhuR0JVay8rUmE4UEhjRWl1T29RM0x4QWY3RGlO?=
 =?utf-8?B?Q2Vzemw1c2tmeGxEZjlCY2JKRjVGbm4rTVdsUDJxLzBKZ05pNnBCL21hblM3?=
 =?utf-8?Q?3+eMHKnrvx5jIygs00qTw6o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWgrVXN0TnBLZUtKTkcwbzQxdStsbXVqVXNvZ1hkMHFQYWJaRVM5elVZaXgw?=
 =?utf-8?B?L284UVJERmdGRDlLZDRGSG01VmhVN01GdTVWL29XbmpsNkNsTW93a3ZGMHM5?=
 =?utf-8?B?clNYTVQraThHS3UvWHFKRngzM3l4d1FxRmxKOVl0Umx1MHR2Y1U0a0ZCWTNn?=
 =?utf-8?B?WUZHK01jWFVyV3NjbXlMS0JwdTl1UWQ2eW41TnJOczVEWWRRMllyTVZvNmJt?=
 =?utf-8?B?YUtadVV2OWh6VVlxa1ljVHFMMFZmRjlBOEd6ZE9jdTY4YVNUbXoxdHYrYTVu?=
 =?utf-8?B?WEg4S0d6WFgweHJpd05pMjhUUFNyT1hlTDFjY0FqZ0lMOS9MNjZndmtGRjhm?=
 =?utf-8?B?M050eEljZ3BLNzdONloyVXQ1YnN2RDhHb1h5a2UwY0lMREhHRHBwUUZScVlR?=
 =?utf-8?B?T1ZrYmJzMmJ4cFlNSWxmUVRGSVF4cnZwNDZVenhQbnJzUHRnanJPZWl5ZkdP?=
 =?utf-8?B?RHh5ZVMvcUs1SmFxME9SWTZiTWkzaWxuS2t6ZS9QdVNQRlJxMHFxZUFLR0pq?=
 =?utf-8?B?YVcybExyNXhNbDhMcm9WWGdnM09SeVpVUTZWR1M1YUlHaDlPMFFrckRoc2FW?=
 =?utf-8?B?UFdteGVKRDRjRkpYRlU2ZmVGajNQeTA5ZnNJem5MaU5PVkpuRVZJUnppeG5a?=
 =?utf-8?B?Y2NXYzlLdHI0SkxjRzRCRFpUMDNiVkx3T0lQU09SOHVsaEVLMDMwQ3dKSTAv?=
 =?utf-8?B?YllINHEyVXdYZmgwWi96c3R2QUkrQndWUlVFTGtXU1dXODh6U1pnaitkb01w?=
 =?utf-8?B?OXhoMFZReVpYR0xLMEFqOGsyVnBuYlJaU0o1L3FXenIxaXYwM3hTeTV5QVM4?=
 =?utf-8?B?eVB3UitwUHZrbkVNZCthSDVPRWQrZm5kV0orWjhwNGkxWWV1NkE1SExkZ1dQ?=
 =?utf-8?B?ak52MS9EazB3aWhkajEzZy83bXh5N0xmUjBVY2x5cVhPbkwxZy9oYWcvWFgz?=
 =?utf-8?B?UW5VYTN3ZG95aVdwU0VhVWovWDFLUDlMcnR2VmpKbzZyS2FZOHBYWnRTbjdt?=
 =?utf-8?B?Wjd1Qm1oOEdiajFxY1A2SVJDdVB3c0w3R2cyTnFwZ1ZXaVl0eG5rV2pKbWx4?=
 =?utf-8?B?WGFGc1lwdDQvL2V6NFZDYXJTME5lSXNldEhKaGNGRDBLVGU1VWFPTnErWmlm?=
 =?utf-8?B?cW9zOVFReGt1d3dvMUZzcmNXZmdkQ2twNnVXc3VacVFJdEkxdVRtZ0w1NWdt?=
 =?utf-8?B?b2piTDB5N1JxRWRHTUtDeTlBOERnam5CRWVxTC92K2FZR1FZN2hTbnJVbDRs?=
 =?utf-8?B?dmMwaXYvV1dPZlhvRkNzOW1vT3RhQ3J4SkhqODNNOGozVWlBcW0zUElXSWls?=
 =?utf-8?B?bHhhcXhmY2FydnhXQmpkeXk3L2Z3VVVHQzBkNEp4bWJEYzFMV3NCMTRqSXZY?=
 =?utf-8?B?bzBYRnZrNWU0RTBYcHFBTUFLbHd1bzc3SmhPd05pMDczRHpPN0lqRXh6NkNz?=
 =?utf-8?B?M0tORS9HUHBJR1VsYmE5NWc0TUdlUTZCQkNGRm1ORGNJNGlhbkxOM2FLazBO?=
 =?utf-8?B?UnduVU54Y3VVTmhOeFMwMkh2SldKTjNoUEhpL2tGb04ydURkWDNBT3FmUVRn?=
 =?utf-8?B?RWFZUU9aVFM5Rk1xWWVwdUdKU1YxbzVKc0FwWms3T2RUTFZ1c21CeDR1ZS9j?=
 =?utf-8?B?U2RGWU9ndW8xbUNmT1RBMmVTRWswdEtNSjB2TXNiZEorTG9WRXdpMXRHYzJy?=
 =?utf-8?B?VGZJWXYyYWsxYjdPa2ZCMmdIczZlM1RzUzdXUDA3WFRpaXNOanBXTXhGbS9Y?=
 =?utf-8?B?bi9QRHJkU1E4L28vV3BMVG16cWhIMjVTN0h0NjU3STczK1lBdzdKWkI4NHFj?=
 =?utf-8?B?Nm5SSG1sOERhRGNJZkVWb2VLZkEyRTA5STFMdGdOdkR6akRLVWllc1NpYW5I?=
 =?utf-8?B?SmFhaXFmTDc5TTBsRG9iWEVXaU9ucWdtNjk4QVZqaXRzWW55YTdhelI5YjRn?=
 =?utf-8?B?TXhnaG4yTzlGaEJrOHJETzVnb0NPTDBOOFJ6cXEzNC9lZ1c1RGREWUVLRURJ?=
 =?utf-8?B?SzdMRUsrZE5LVzNpczFLVk9nTHZtMzIxVVJFVnVhdGI2R215WDdkSE1tUXJs?=
 =?utf-8?B?NXRqV2oyZGRaN2txS0hEcTU3SitvRHNMRUdqU3NWTFhIUTJTTFdMc3ZRK2Ja?=
 =?utf-8?B?SkVnZlhxSllCSWhBSHg5REdQVElNRHQxTElmTmgyMUtyM0lNeEhxR2wvUGhQ?=
 =?utf-8?B?R2ZVT0lHaE1KeFFBWXVRc2NOKzZyMVRSUFgrdkJ5Ylpqb0RjUmxQMlgwUngw?=
 =?utf-8?B?MHNkU28vNGN1Uy8yM1BJLzlGSFZkUE0ya0xDTTRaWXd1Z2NHMVBzNGdmZHV1?=
 =?utf-8?B?WDd0RlVYN0pCbVBVMnFTV21LRkJOeGpoWThtN2VTUDJaTzhOZVZxZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 183494ab-3cde-4a2c-c292-08de5e97e331
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 18:05:57.9159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: acCuQFhxeDu7hEhltABf8foL3tJuQflsAt4M9oLBJGsSNHy2qDt59PHKJbJivQSG3hBixHXuXXmh4P8nbxekOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8145
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-8563-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+]
X-Rspamd-Queue-Id: CA62CA784B
X-Rspamd-Action: no action

Split vchan_tx_prep() into vchan_init_dma_async_tx() and __vchan_tx_prep()
to prepare for supporting the common linked-list DMA library.

struct dma_async_tx_descriptor already contains the dma_chan pointer, so
drivers do not need to duplicate it in their own descriptor structures
derived from vchan_desc.

Previously, dma_chan was NULL during descriptor preparation because
vchan_init_dma_async_tx() was called too late. Initializing the
dma_async_tx_descriptor earlier allows drivers to directly access
dma_chan during the prepare phase.

No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/virt-dma.h | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
index a15f9e318ca5ec7fd3c4e6fc6864ad3d1dc3eaa5..ad5ce489cf8e52aa02a0129bc5657fadd6070da2 100644
--- a/drivers/dma/virt-dma.h
+++ b/drivers/dma/virt-dma.h
@@ -80,17 +80,22 @@ struct virt_dma_desc *vchan_find_desc(struct virt_dma_chan *, dma_cookie_t);
 extern dma_cookie_t vchan_tx_submit(struct dma_async_tx_descriptor *);
 extern int vchan_tx_desc_free(struct dma_async_tx_descriptor *);
 
-/**
- * vchan_tx_prep - prepare a descriptor
- * @vc: virtual channel allocating this descriptor
- * @vd: virtual descriptor to prepare
- * @tx_flags: flags argument passed in to prepare function
- */
-static inline struct dma_async_tx_descriptor *vchan_tx_prep(struct virt_dma_chan *vc,
-	struct virt_dma_desc *vd, unsigned long tx_flags)
+static inline struct dma_async_tx_descriptor *
+__vchan_tx_prep(struct virt_dma_chan *vc, struct virt_dma_desc *vd)
 {
 	unsigned long flags;
 
+	spin_lock_irqsave(&vc->lock, flags);
+	list_add_tail(&vd->node, &vc->desc_allocated);
+	spin_unlock_irqrestore(&vc->lock, flags);
+
+	return &vd->tx;
+}
+
+static inline void
+vchan_init_dma_async_tx(struct virt_dma_chan *vc, struct virt_dma_desc *vd,
+			unsigned long tx_flags)
+{
 	dma_async_tx_descriptor_init(&vd->tx, &vc->chan);
 	vd->tx.flags = tx_flags;
 	vd->tx.tx_submit = vchan_tx_submit;
@@ -98,12 +103,21 @@ static inline struct dma_async_tx_descriptor *vchan_tx_prep(struct virt_dma_chan
 
 	vd->tx_result.result = DMA_TRANS_NOERROR;
 	vd->tx_result.residue = 0;
+}
 
-	spin_lock_irqsave(&vc->lock, flags);
-	list_add_tail(&vd->node, &vc->desc_allocated);
-	spin_unlock_irqrestore(&vc->lock, flags);
+/**
+ * vchan_tx_prep - prepare a descriptor
+ * @vc: virtual channel allocating this descriptor
+ * @vd: virtual descriptor to prepare
+ * @tx_flags: flags argument passed in to prepare function
+ */
+static inline struct dma_async_tx_descriptor *
+vchan_tx_prep(struct virt_dma_chan *vc, struct virt_dma_desc *vd,
+	      unsigned long tx_flags)
+{
+	vchan_init_dma_async_tx(vc, vd, tx_flags);
 
-	return &vd->tx;
+	return __vchan_tx_prep(vc, vd);
 }
 
 /**

-- 
2.34.1



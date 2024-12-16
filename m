Return-Path: <dmaengine+bounces-3977-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4589F2B4C
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 09:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED4D7161AEA
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 08:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A81200BAA;
	Mon, 16 Dec 2024 07:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qVQmPqYO"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66131200B9B;
	Mon, 16 Dec 2024 07:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734335925; cv=fail; b=qPSzbSpfqEnFYU57EwFBFN2DJKKjDw3dhO9OUPhZERHsJS66Ya8BXnGGwKH8topzb6GPEYdG2Jh61KERdslJe0aAKXa/ErgolPzyKmWDc/nRhG4W6rr4zmpcuZXDm/g2o9noOITc8DngPreXpqX/TtleqKd/Q2Z+dxMUd0t6/44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734335925; c=relaxed/simple;
	bh=NBoQw/AdDf2L/90aAfoyiXpqnbBFwZm7q+nVg3ewCjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q11GaZ1+y43DKAn/Ygm7vgP1Xs2kmogNYJh8IVsXWUncv8YNkWuvK/iFsfk3HjkZ9ZmT+ER5Jpyp9QWt68urX7vpkw3laGV6Kmt3yVyrvbGWiIqQByN57Hbw/S7l7TqSvoekxA1fVgBPw9gG80B5Zxz2Nzo9a9w74nCfdSDttUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=qVQmPqYO; arc=fail smtp.client-ip=40.107.20.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQlcc7mHUo/kzF2ZQrCfkYQo6PQye1k+npgKVKA43ubGKfPW9xQlkgEAhZgyl/fC+wEvlx7nnM+Yx5mTLu1E1hH093PHrTAehyDnYMG/FFne59ybeYR4TBbztMfS4lofV0xngwwp8v+NHeV4czQ65s17PCuT6s8LGaycNOW7+4B5s7Cl1wR7g8U+9L0dSqYsHsu059GIAsIyl00dVOvUPADJH/1Tzw1R3pj/nPRDo37J8RbuNpEzw8tTi4gnYDuq9VZ77vx0aeVbiNjIREgnSm0tpfdjuhCuWaikbZAsciQv0QAMLT/2rTHIm09KKapFjcviPQIz6I9qFwONqrw4eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHxEgU9gLnV0LuycV1V4GglatHZ7PT7InM7xeDPyKQc=;
 b=SYyY82VzoVYN2JQRtIg77eaLBK8AL4ZPGeYx7qzS72b/dKBqWu5kGQ0bguX5yisCesvoy0lAzy1yoVXF6K0+S86u4s233SL2/FhUbnuUnvM5ZQvjViBLtzskDGEg4ubXSkirLr4yEL4UyuAtuw6ZIP46Fu9UCkn72/J2RfEv/aPGwMJ5BXqIBvvI9R7QDC9xIwFBa9+uXlS9HWt2k2eggshoHC1pwAfjq4tkqmvaaKMuPAwqVgRKZCTYqDesvZRohiLTOh82JyQ/05MpJy7PFzBxS3mTYR0/0WkqAVZnyRJ9RPyHt3EPejz0jqyuFx1FyUH2axAer3MBnJPtgGwE0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHxEgU9gLnV0LuycV1V4GglatHZ7PT7InM7xeDPyKQc=;
 b=qVQmPqYO+I/u8FZqOMz6t04QHhDyb3j+ckqtmZ0jfthZb071Z8aeMmbdEUvlj2ZcZT0Ge2MPiDUcuG4wxXGpNKLDQk6I0iBS4npqrYnCWIL3fsjPD2hauWCVhJQ/yTdwgUgNzmiQzkBQTx2qqVeGhZ1oVkv1KdAMqoMBZ75w1ajfWkESZx5IYu4nd+zEZ9bPDq8Hj6nJjWPX1rsoaTpyfsnEyHG7GPdo21MUA4yh9/6zVECUkBbs6vQ9JLYLneSU3t+NWbG95nyLUsGn3OGzUiIjnM0fLQN0aaDikKUqFIjOZ2AU9iYUk0pB2dmJCahCRovojpKC+4oXzP6/oMMXkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com (2603:10a6:20b:4f9::17)
 by DU4PR04MB10361.eurprd04.prod.outlook.com (2603:10a6:10:55d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 07:58:36 +0000
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7]) by AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 07:58:36 +0000
From: Larisa Grigore <larisa.grigore@oss.nxp.com>
To: Frank.Li@nxp.com
Cc: dmaengine@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Larisa Grigore <larisa.grigore@oss.nxp.com>,
	Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
Subject: [PATCH 6/8] dmaengine: fsl-edma: add support for S32G based platforms
Date: Mon, 16 Dec 2024 09:58:16 +0200
Message-ID: <20241216075819.2066772-7-larisa.grigore@oss.nxp.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241216075819.2066772-1-larisa.grigore@oss.nxp.com>
References: <20241216075819.2066772-1-larisa.grigore@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0076.eurprd04.prod.outlook.com
 (2603:10a6:208:be::17) To AS4PR04MB9550.eurprd04.prod.outlook.com
 (2603:10a6:20b:4f9::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9550:EE_|DU4PR04MB10361:EE_
X-MS-Office365-Filtering-Correlation-Id: 394d6c98-f0cd-48be-5d20-08dd1da771bb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3RpbzZyQ0NFNzJnekU2SGFwd2N1eW9ZdnN5eUZEdk5adUN4ZllLcTUzZHp0?=
 =?utf-8?B?N1lCV0xia2tnc3VoU2ZlUzh2SHFRWEhEWE1ETUFJd1BKZFk5U0dvT1pjWWJ6?=
 =?utf-8?B?dTRkL0lCS1YySnd0NkRoSXBVOGp5MW4vUXdqSGIwSTRhbUJQM3F0c0I5dUF2?=
 =?utf-8?B?bCtFVlBnazEwS2xHcVVqZm5EZmhiemRLZkU5U1ljNzR0NkZHemJQNmJKNGp2?=
 =?utf-8?B?Uldjbk1uNXJGNU1MNU8zZDc3SndlYktVOXNDcEZCQ1lUOThIUW1uNnAvdy9I?=
 =?utf-8?B?TmpkN2FDNGRkYXZvUnVGVWxGd0FYQUpWNnkwQmZ6N0VZVEUzR0c0emhrVGFF?=
 =?utf-8?B?QlRRZEtjRmErVGJuM2hka2tDMnJJeTl1S05DdE9rZmt2c1lwS1QwS1o4bGMw?=
 =?utf-8?B?U0ViaEQ0dWFrMjkrZmNtd1lHeXdyTG9HSXFNdVVWTXR0WVdmc2R5ekhBWFRX?=
 =?utf-8?B?K0liSkpNY0JUT013SVk3NkREZXp1VEFJS0krZkNYNlJ5N0ZSL3NwSG1sTzJ5?=
 =?utf-8?B?MHphdVMzaFNLcXhxbmxiSCt3VmVCbjNsTnR1a0o5WksxemwzRkp4d1BQTzNT?=
 =?utf-8?B?MlBOVElZK1VkaDJzUjZJZUJuYXp4WEN3RGcvRG9zNGl2L0hSeFR0T21rTDBt?=
 =?utf-8?B?eEhZQzJUc0VzMjNpaVRneUtySWk5cGt0WkpVdjh2WDFjSnhmYklsRjA2NUFE?=
 =?utf-8?B?RHBBMjdZdjhEYjQvUWJvLzM0THR1OUJTSDY1cmlaN0lhY0QwaHpMTGdLYStu?=
 =?utf-8?B?alAxblExYk1LbmV5QnJQbklDMmFoR1phaGE4VmllR0hKaVFJZVRVamhEU1Fz?=
 =?utf-8?B?UWltT0JLS2tlYXU0K3QyL2VMUWlrZUtkN3NLRW9wSGc1TzR0UzByLytaQlhl?=
 =?utf-8?B?Uk1qUGxBVk9LQlJwMGpicnBBUlcrUDJBV2Z6L0d5YnQ2VEUwdW5WUllpVFRE?=
 =?utf-8?B?OHM1SHk5T1JLVmFmakt2amVCQTh3eFcvREs5akl4aU05NjRDdzZIZmNXTXht?=
 =?utf-8?B?bzBDdm5FbDE2eWY3SzBKZ0M0OWU3VXluRnJHMjdTLzI0SDNIMkMzbjNBTUFl?=
 =?utf-8?B?SWUvVjdaTkoySEtsb3UyU3JaSWI3MVpNTENXd25QSnRPSk15S3RWTEJCdnlE?=
 =?utf-8?B?WmpoMmJvaUxjMGFrTnRweGlESFBwdU10YkNsM3REODhZb2ZBd1VWcWF5U0Z0?=
 =?utf-8?B?d3FHeXJLUStKTENLQzlMMDhQNWwvY091THFGcGN5T0FZb09FS3BsL2RKc1J0?=
 =?utf-8?B?bUtnUy9kd3V3NGJVb1hqN0lWMWdJYmcwNkptY3drdVNxUDVjYmsycDVMTXM2?=
 =?utf-8?B?K1UwS1lqT3FZdXFSRUJzbHFMKzdtYjdHR0VZb0Nyb0NhN0xGWkxheVozZTNp?=
 =?utf-8?B?QVp4YXNqZHFWOWNoRzF3aEtOVDIzS1hIT2tmV1NyckNxWXpUcE9IT0VWeTFn?=
 =?utf-8?B?WEFTNTREN1g5cFRZWGd5UDNjZGJ1L3NQUmVYNVVPa2M1VmVEbDNhcUxwcTJU?=
 =?utf-8?B?bXBuNGFKMFdUbDhINVJxd1VVVFBubThHUUd5dWJNS1pGRlRzc3ZUYWdZT0xY?=
 =?utf-8?B?ZVk1K05yTm9HdVZwYTlKdTE2R0lXeEFiOGdSQzA3MFVYc0QwYmgvLzE4RXJN?=
 =?utf-8?B?Q3dhcDRYSVM0WWxwelR4NVBCRG04Z1ZnejBKN01JdWNodll2VGNFeGhoQmpQ?=
 =?utf-8?B?Yy9rbjg2eHY1MG13RHdTY0l2eVJZdzhoZEsxMmxuZVg3UmZaUlBLUm5lbFZY?=
 =?utf-8?B?a21XTjdZMDZLTkd0NVl1SlBEVHVWYWlZNEV4OTZaL0gvQXh4aU41OXVpZEZD?=
 =?utf-8?B?S0ovZzVqQ1RvZ2crNVNOQVV1UWN4dTk1WnErT0xMZVViejVDNWVCcTVtSDNE?=
 =?utf-8?Q?hdfN95kKL7FG4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9550.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STVGNkxFckNCSExNSk5sVGIwb1JkeTR5ZGxCY2x0V3JpNG8rV3JVUmpRQVdz?=
 =?utf-8?B?SVlqTHBVaVl3eU1Mdm5wcjlLUXNqZFJ4NEVNL3N2eHJGV3YxK21pcXVvMFdq?=
 =?utf-8?B?QnhoOW15c282UDU2N2Jlalg0R2hiQ1ZyS082TGlRVmJjMUl5VDdvc2lhV2JP?=
 =?utf-8?B?NUpTYzIzV3FzckFFQUg5c29VNDgvSDZQcmhIc1R5M0JVWG1TNGc3Mlg5N0NH?=
 =?utf-8?B?VnRzNnF5eVBURk1rQlJ4NFE5bFdtcnFhYWxjbnE5bmtORVhXdkdYMHE5a0hy?=
 =?utf-8?B?bHJxNXNWc0JrdjRqMkFJS29jTTV1UUFSRUxCVGxnbXhvSjJTNGpaWUpRRVB4?=
 =?utf-8?B?ZFZxdkZIRE9OL0NkUkVSdVp6d01rZ0l2SVk3c0phYnNsaXJPbVBSTS9sT0tr?=
 =?utf-8?B?Tys2UE1tZU9kNTNCbkNCa2c4eCtsOVNxak9NMHZPeEptOGZXcEJlZitiNXFY?=
 =?utf-8?B?Q0UwNzNXUE12ZFpTZjUrenMvTjZTZUxXQXZoSWNRK0ZBQWoyS3hoeHJaVFN0?=
 =?utf-8?B?cXY3VEFpZ3F6Uy8xSnRFNm9kb2NMcFlrL1BWWmlveTlLYzFIbHd2Um5lYitt?=
 =?utf-8?B?VU4rZk5BNFRBLzh4ejhvRVlvVEhiejBSdlQ1MFlueTBZM1o4VjBockIwK2ZH?=
 =?utf-8?B?THhZVlpYZ25iUFl5eDEzeFNTaU1CTHA5bTRwWHFqR2JqK2dYUUN5bVZ3VGZz?=
 =?utf-8?B?cHlweTF5bXM1R2lOQk1YS3Bua2syRTU5YUpuSW1HQ0hGSWMwYzR6SkUvWHA1?=
 =?utf-8?B?MHpnU2ErU0ZKSmRpeUM5elFiQ09NRHZFeXZXMzhISjdBRnovOGNtNlA4M0dX?=
 =?utf-8?B?clhXOVIrZy9hR1ZFUXdweTBLQmdRZ3VLak94eXBJcWlHdFhHald6ZGxleUVw?=
 =?utf-8?B?ZVYwTTRFc0dWRWpkRTAwNXM0NXR2UU5LcVpSSkNkTm0zRGI4WnIxQ3FoUEs0?=
 =?utf-8?B?ZnQrMjRnUkVOZDcwQldIWkI3ZzFJeElvbWNnV0Y5VlZxaTdRTWVvZXk0cTQ3?=
 =?utf-8?B?aUk0dlB0VWllZGtDQldkRHdIdXJHT2F3S3JYMWRZc3VaSnFmVVRGMTJjTnpN?=
 =?utf-8?B?RkxMSmFBWGloZUpzNEx5KzQycWNtZFA5UUZ6UjZ1N3lBRzBRZVR5UmN1b3VI?=
 =?utf-8?B?b1FOc1FUQUtidi9HWXlSYUNkWTRyYmZrNU9lK09rb3VqUHFxaEdLdndjTmJS?=
 =?utf-8?B?bXIzL3Q3SXgxdUNXc1kveWQ4eTZTUjlxL3hsNDA3NVYxeEdzSCt5L28zK2ZT?=
 =?utf-8?B?WFV3Zk14RVJhRXhWTU5Ja3RlL2VqcU1TeXVzdUhUaGpUazNQQkd2TjN6Rlo3?=
 =?utf-8?B?SURwVWx2dUx0Z0NIdDBKMU1FSDVlY3JWbWtWL3hXamtQZ2hrSXNYYkZMbXgy?=
 =?utf-8?B?K0t1VFFXektRMHFBSklIajkwcEVPb2xzaUdROHFoRlJpZlA5TVhxc3RBdFpl?=
 =?utf-8?B?WEJiamJDdnZsUVhHTXN3YnBiZG5naCtITzZXTGMreFlIY1hOMzBYa0F4MVFP?=
 =?utf-8?B?QnVvMHJ4dytRV1NhSEtTa29vVWQrN2RzRHNsU0g0Y2QyZmZ1K1JFNU9FMENU?=
 =?utf-8?B?YVhSWHBHZWV4bDZYdGFlTXVNNTJ0RWJncERaZGt2R2V6Mm9jYldpWXM2M0dV?=
 =?utf-8?B?aDBQUlVzbnZLaFdFS21LZ3dhbDBzZnlIbE1nTGNuTEdtblBBbC9QK3hOblhR?=
 =?utf-8?B?aXU5QW5sWTE0SUpVRzI1T1NBS09TWGhMQVIzQ29aTTJJK29mVWJoQnhkZGhk?=
 =?utf-8?B?LzJhYVpzMDFNU1N5R3VmWXRyZUR2V0dJSUpndi8ydllPSFg0K1NWdU55dDFV?=
 =?utf-8?B?Z1IyNkxrYUVsS0xvNDZXa01LZisyTWNla1dXM1A1T0NSNDlmb2JySk04a21O?=
 =?utf-8?B?N0hZeVNjV2d1K3cxZ21scG1LeHdXOG4yTzZCUUxLNmJuVFJHbzJDbkIvQ0NG?=
 =?utf-8?B?S1pjaWxxeXhlQkJNWnp1U2drRTF4N29VSGVOVXA5YUNMcjV5SWplZ1NyMGEr?=
 =?utf-8?B?cEJIaFRNN091RDJLWFFDWG82T1lNOE51aHFxOEVEZ0QwbWN5S3hLVHJkMldK?=
 =?utf-8?B?ZEQvdGYvdkZQMVdoM0cwZVBmTFByYlY4OWx5WEZ4SmdHZFVXSytOb21XYmNE?=
 =?utf-8?Q?AGM+y15h6A1i3QVwhebDZ11bN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 394d6c98-f0cd-48be-5d20-08dd1da771bb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9550.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 07:58:36.2765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2MnQBQUjOfbXzLZV5c3NTtocEv+PJcqUlW0q4vfiNA+V66TmGMhiGLvDtvfRgJbZlWRUO6L62ijdEdWJswP9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10361

S32G2/S32G3 includes two system eDMA instances based on v3 version, each of
them integrated with two DMAMUX blocks.
Another particularity of these SoCs is that the interrupts are shared
between channels as follows:
- DMA Channels 0-15 share the 'tx-0-15' interrupt
- DMA Channels 16-31 share the 'tx-16-31' interrupt
- all channels share the 'err' interrupt

Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
Co-developed-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
---
 drivers/dma/fsl-edma-common.h |   3 +
 drivers/dma/fsl-edma-main.c   | 109 +++++++++++++++++++++++++++++++++-
 2 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 52901623d6fc..63e908fc3575 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -68,6 +68,8 @@
 #define EDMA_V3_CH_CSR_EEI         BIT(2)
 #define EDMA_V3_CH_CSR_DONE        BIT(30)
 #define EDMA_V3_CH_CSR_ACTIVE      BIT(31)
+#define EDMA_V3_CH_ES_ERR          BIT(31)
+#define EDMA_V3_MP_ES_VLD          BIT(31)
 
 enum fsl_edma_pm_state {
 	RUNNING = 0,
@@ -252,6 +254,7 @@ struct fsl_edma_engine {
 	const struct fsl_edma_drvdata *drvdata;
 	u32			n_chans;
 	int			txirq;
+	int			txirq_16_31;
 	int			errirq;
 	bool			big_endian;
 	struct edma_regs	regs;
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index cc1787698b56..27bae3649026 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -3,10 +3,11 @@
  * drivers/dma/fsl-edma.c
  *
  * Copyright 2013-2014 Freescale Semiconductor, Inc.
+ * Copyright 2024 NXP
  *
  * Driver for the Freescale eDMA engine with flexible channel multiplexing
  * capability for DMA request sources. The eDMA block can be found on some
- * Vybrid and Layerscape SoCs.
+ * Vybrid, Layerscape and S32G SoCs.
  */
 
 #include <dt-bindings/dma/fsl-edma.h>
@@ -73,6 +74,60 @@ static irqreturn_t fsl_edma2_tx_handler(int irq, void *devi_id)
 	return fsl_edma_tx_handler(irq, fsl_chan->edma);
 }
 
+static irqreturn_t fsl_edma3_or_tx_handler(int irq, void *dev_id,
+					   u8 start, u8 end)
+{
+	struct fsl_edma_engine *fsl_edma = dev_id;
+	struct fsl_edma_chan *chan;
+	int i;
+
+	end = min(end, fsl_edma->n_chans);
+
+	for (i = start; i < end; i++) {
+		chan = &fsl_edma->chans[i];
+
+		fsl_edma3_tx_handler(irq, chan);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t fsl_edma3_tx_0_15_handler(int irq, void *dev_id)
+{
+	return fsl_edma3_or_tx_handler(irq, dev_id, 0, 16);
+}
+
+static irqreturn_t fsl_edma3_tx_16_31_handler(int irq, void *dev_id)
+{
+	return fsl_edma3_or_tx_handler(irq, dev_id, 16, 32);
+}
+
+static irqreturn_t fsl_edma3_or_err_handler(int irq, void *dev_id)
+{
+	struct fsl_edma_engine *fsl_edma = dev_id;
+	struct edma_regs *regs = &fsl_edma->regs;
+	unsigned int err, ch, ch_es;
+	struct fsl_edma_chan *chan;
+
+	err = edma_readl(fsl_edma, regs->es);
+	if (!(err & EDMA_V3_MP_ES_VLD))
+		return IRQ_NONE;
+
+	for (ch = 0; ch < fsl_edma->n_chans; ch++) {
+		chan = &fsl_edma->chans[ch];
+
+		ch_es = edma_readl_chreg(chan, ch_es);
+		if (!(ch_es & EDMA_V3_CH_ES_ERR))
+			continue;
+
+		edma_writel_chreg(chan, EDMA_V3_CH_ES_ERR, ch_es);
+		fsl_edma_disable_request(chan);
+		fsl_edma->chans[ch].status = DMA_ERROR;
+	}
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t fsl_edma_err_handler(int irq, void *dev_id)
 {
 	struct fsl_edma_engine *fsl_edma = dev_id;
@@ -276,6 +331,49 @@ static int fsl_edma3_irq_init(struct platform_device *pdev, struct fsl_edma_engi
 	return 0;
 }
 
+static int fsl_edma3_or_irq_init(struct platform_device *pdev,
+				 struct fsl_edma_engine *fsl_edma)
+{
+	int ret;
+
+	fsl_edma->txirq = platform_get_irq_byname(pdev, "tx-0-15");
+	if (fsl_edma->txirq < 0)
+		return fsl_edma->txirq;
+
+	fsl_edma->txirq_16_31 = platform_get_irq_byname(pdev, "tx-16-31");
+	if (fsl_edma->txirq_16_31 < 0)
+		return fsl_edma->txirq_16_31;
+
+	fsl_edma->errirq = platform_get_irq_byname(pdev, "err");
+	if (fsl_edma->errirq < 0)
+		return fsl_edma->errirq;
+
+	ret = devm_request_irq(&pdev->dev, fsl_edma->txirq,
+			       fsl_edma3_tx_0_15_handler, 0, "eDMA tx0_15",
+			       fsl_edma);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+			       "Can't register eDMA tx0_15 IRQ.\n");
+
+	if (fsl_edma->n_chans > 16) {
+		ret = devm_request_irq(&pdev->dev, fsl_edma->txirq_16_31,
+				       fsl_edma3_tx_16_31_handler, 0,
+				       "eDMA tx16_31", fsl_edma);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret,
+					"Can't register eDMA tx16_31 IRQ.\n");
+	}
+
+	ret = devm_request_irq(&pdev->dev, fsl_edma->errirq,
+			       fsl_edma3_or_err_handler, 0, "eDMA err",
+			       fsl_edma);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Can't register eDMA err IRQ.\n");
+
+	return 0;
+}
+
 static int
 fsl_edma2_irq_init(struct platform_device *pdev,
 		   struct fsl_edma_engine *fsl_edma)
@@ -406,6 +504,14 @@ static struct fsl_edma_drvdata imx95_data5 = {
 	.setup_irq = fsl_edma3_irq_init,
 };
 
+static const struct fsl_edma_drvdata s32g2_data = {
+	.dmamuxs = DMAMUX_NR,
+	.chreg_space_sz = EDMA_TCD,
+	.chreg_off = 0x4000,
+	.flags = FSL_EDMA_DRV_EDMA3 | FSL_EDMA_DRV_MUX_SWAP,
+	.setup_irq = fsl_edma3_or_irq_init,
+};
+
 static const struct of_device_id fsl_edma_dt_ids[] = {
 	{ .compatible = "fsl,vf610-edma", .data = &vf610_data},
 	{ .compatible = "fsl,ls1028a-edma", .data = &ls1028a_data},
@@ -415,6 +521,7 @@ static const struct of_device_id fsl_edma_dt_ids[] = {
 	{ .compatible = "fsl,imx93-edma3", .data = &imx93_data3},
 	{ .compatible = "fsl,imx93-edma4", .data = &imx93_data4},
 	{ .compatible = "fsl,imx95-edma5", .data = &imx95_data5},
+	{ .compatible = "nxp,s32g2-edma", .data = &s32g2_data},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_edma_dt_ids);
-- 
2.47.0



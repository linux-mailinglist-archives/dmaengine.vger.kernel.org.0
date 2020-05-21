Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658071DD32D
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2020 18:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgEUQkS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 May 2020 12:40:18 -0400
Received: from sonic309-21.consmr.mail.ne1.yahoo.com ([66.163.184.147]:39691
        "EHLO sonic309-21.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726938AbgEUQkS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 May 2020 12:40:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1590079217; bh=6mffK3RH01pMSJbI3gzRyn/TJ4jPuu2pqeTpPbg3ras=; h=Date:From:Reply-To:Subject:References:From:Subject; b=bmgUFqxhphgB+lVR2l4N0IgTMxtrzk2dO+tCIZ7TjVEb67akvi0pOdX/LMn0i5281NNkieVoEW6o+UQR+pvsp5daRJBueaWKBbK4G50ityoEopeFdJZRVL6JyJ63y4q0ZXS7QBVm4Ew1ffWhH2leOiXy1x84I5h2V2yPbQ4hAirUBy9tzZrnd0zFl98czdSfgvb9i0MaDeGaUUnlFqqX4UjGX76yLt+MpkTwxQLfaaKoOhdcHO581CGEDkqhxZWvPx+o6iLSgD7ZRQT1N5KHVWU2b0n/c5nG8dI6f2I0XOMCy6CVbt3hzYy8MPV1FeQhHPYeu/3TdXFCRbKGBKqpzA==
X-YMail-OSG: nkiE0tIVM1lGS9B0IUE.wEHq8DUq38kV4ZQTO9RXmOTwT2H3u1cGiGPFbw0lK2P
 63NnZGRFm2zt9yD2B.DTBgA3YeOl6guFU.bHb7z1G78zunIAG.40rPq6QnOSmDi6GBKCjUHr6Hkx
 dl6Ez3HFkDc6Vz0Pv7N0rcN8lWPTylluv3KgYSK3dGBu2.vF9o5Y8AxrzeTXiu53Hcx6VRoRFpYX
 UmF.4kHnFTimCI4LSjQER7gQenbdXS6FEvRs9BiySTqBpUliqbZUEvaxxlpeoMUfmzfWm8Est857
 zg8svbLL8oMsHwTMStdKJkPjAlNMgwN6DHPEza4u5Wk9quP.yiMAeBFBm3YXYazVpacLxs4gYopY
 L94n4PqRIkXSfquvpDzav7yqL1OiTBQdKpXvnvmNzF_37skzR_MLl5MM880p66mAuUC2qjg14fZi
 4w7BqgcExdxkmxERt.oz1a.4.Gs92xMHilfYgXOw8kKOwKJ7I.yVICQrvrs9gpePHTC5hkHGsaP_
 XQk4jQL_BxmFO5HlLk7dTDUv2kqh9_wiIWM3NDT5QiGMjJJxtMBg.X0KfqhmZkipODuSb5_Q_aBn
 kHFyyQqhNQmOh8E15HMluv6WENxvprbQcsTwYc4V9dC2PZhUeIkvjlUTee7sovBjhGwqLurFk7uI
 EVWhrtWFpsXqGXYSsf7dzCrM8QPlTyvds5Ysqwajt6ZcgNVwP8nnkCCTP1jWOuF.PXYYxrtCqQxW
 _LFnuxDAgxNOfgNYGp_MltHClS4pGd5ZXpilZx0SMT3TqDsl1wIa34GLQ2oSbp5QyDu0kLZEZo6y
 nZ8ZBxucBlrDmWtfltV.pA6JY1ghqp0LsCTafyTigO5OHgYaLYJzugycFmmOMz6Kf0osKK6H4nEf
 yMzipP.fwGLPPqwzj8YXalGULw_9rtEOJ2l1qww57jz3C3.y_wYrgMek7Iy.H9gPewCz61T8FRaE
 lgZoZ9gGP5j_MlNbYpbjKTzxDGo5yX3nTXLyz_Rs3oNmbJs_XgEOHpfzLPty0SrL3OEgTKYcHgBH
 ihVfqdNeYB4As5p.KtGa0HCtNEwxQERHD6mVl6iBzc96nJpBEClBUA4kvQnpMHPppHqHzs.E3fxM
 XAyiAQTCJshY5I5zAAElybHrUQ.g.yVNEZBLJUpLz7BXMU2MQmbwJe8C_8FVIA7bO_Q2L7YKbis2
 DjH4MW10RsCRdAp3qv43CicwwKl.vWnHyxQrdZrTzOvhCAOq2Oo.ky56r7.1qx1WdcADMA7u335A
 1xhlHSle6Q6xy5Bs5TPSaPyZZBa8sibpHPKqhx8qjn32LikASaItDqH4YZWZxalXsl4zIvwLV
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 21 May 2020 16:40:17 +0000
Date:   Thu, 21 May 2020 16:40:15 +0000 (UTC)
From:   Rose Gordon <rosegordonor@gmail.com>
Reply-To: rosegordonor@gmail.com
Message-ID: <906707607.513086.1590079215075@mail.yahoo.com>
Subject: Hi there
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <906707607.513086.1590079215075.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15959 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:72.0) Gecko/20100101 Firefox/72.0
To:     unlisted-recipients:; (no To-header on input)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Best of the day to you I'm Rose by name 32years old single lady, Can we be friends? i was born and raised in london in United Kingdom Take care Rose.
